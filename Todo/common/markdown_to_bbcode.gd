extends Node


func _init():
	self.links = {}
	self.codes = []

func _ready():
	pass

func gather_link(m):
	links[m.group(1)]=m.group(2); return ""

func replace_link(m):
	return "[url=%s]%s[/url]" % (self.links[m.group(2) or m.group(1)], m.group(1))

func gather_code(m):
	codes.append(m.group(3)); return "[code=%d]" % len(codes)

func replace_code(m):
	return "%s" % codes[int(m.group(1)) - 1]


class translate():
	func _init(p="%s", g=1):
		self.p = p
		self.g = g 
	
	func inline(m):
		s = m.group(self.g)
		s = re.sub(r"(`+)(\s*)(.*?)\2\1", gather_code, s)
		s = re.sub(r"\[(.*?)\]\[(.*?)\]", replace_link, s)
		s = re.sub(r"\[(.*?)\]\((.*?)\)", "[url=\\2]\\1[/url]", s)
		s = re.sub(r"<(https?:\S+)>", "[url=\\1]\\1[/url]", s)
		s = re.sub(r"\B([*_]{2})\b(.+?)\1\B", "[b]\\2[/b]", s)
		s = re.sub(r"\B([*_])\b(.+?)\1\B", "[i]\\2[/i]", s)
		return self.p % s


func markdown_to_bbcode(s):
	self.links = {}
	self.codes = []
	# 替换
	
	s = re.sub(r"^\[(.*?)]:\s*(\S+).*$", gather_link, s)
	s = re.sub(r"^    (.*)$", "~[code]\\1[/code]", s)
	s = re.sub(r"(?m)^(\S.*)\n=+\s*$", funcref(translate("~[size=200][b]%s[/b][/size]"),"inline"), s)
	s = re.sub(r"(?m)^(\S.*)\n-+\s*$", funcref(translate("~[size=100][b]%s[/b][/size]"),"inline"), s)
	s = re.sub(r"(?m)^#\s+(.*?)\s*#*$", funcref(translate("~[size=200][b]%s[/b][/size]"),"inline"), s) # 一级标题
	s = re.sub(r"(?m)^##\s+(.*?)\s*#*$", funcref(translate("~[size=100][b]%s[/b][/size]"),"inline"), s) # 二级标题
	s = re.sub(r"(?m)^###\s+(.*?)\s*#*$", funcref(translate("~[b]%s[/b]"),"inline"), s) # 三级标题
	s = re.sub(r"(?m)^> (.*)$", funcref(translate("~[quote]%s[/quote]"),"inline"), s) 
	s = re.sub(r"(?m)^[-+*]\s+(.*)$", funcref(translate("~[list]\n[*]%s\n[/list]"),"inline"), s)
	s = re.sub(r"(?m)^\d+\.\s+(.*)$", funcref(translate("~[list=1]\n[*]%s\n[/list]"),"inline"), s)
	s = re.sub(r"(?m)^((?!~).*)$", funcref(translate(),"inline"), s)
	s = re.sub(r"(?m)^~\[", "[", s)
	s = re.sub(r"\[/code]\n\[code(=.*?)?]", "\n", s)
	s = re.sub(r"\[/quote]\n\[quote]", "\n", s)
	s = re.sub(r"\[/list]\n\[list(=1)?]\n", "", s)
	s = re.sub(r"(?m)\[code=(\d+)]", replace_code, s)
	return s
	
func markdown_to_bbcode(s):
	self.links = {}
	self.codes = []
	
func translate_headline(s):
	var regex = RegEx.new()
	var compile_str = ""
	var font_str = ""
	for i in range(1,6):
		compile_str = "^" + "#".repeat(i) + "\\s+(.*?)$"
		regex.clear()
		regex.compile(compile_str)
		font_str = "[font=res/" + str(32 - (i)*4) + "px.tres]$1[/font]"
		s = regex.sub(s,font_str,true)
		print(s)
	return s
