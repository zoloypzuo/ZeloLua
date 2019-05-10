def xml_tag(tag, code):
    '''
    def para(code):
    return ['<para>'] + \
           tab(code) + \
           ['</para>']
    :param tag:
    :param code:
    :return:
    '''
    return ['<{tag}>\n'.format(tag=tag)] + \
           tab(code) + \
           ['</{tag}>\n'.format(tag=tag)]


def para(code):
    return xml_tag('para', code)


def remarks(code):
    return xml_tag('remarks', code)


def summary(code):
    return xml_tag('summary', code)


def see(link, code: str):
    '''<see href="http://stackoverflow.com">HERE</see>
    code单行，返回一个一个元素的list
    '''
    return ['<see href="{link}">{code}</see>\n'.format(link=link, code=code)]


def xml_doc(code):
    '''xml doc顶层是tag列表，不过仍然是code
    为所有xml doc添加前缀的三斜杠
    '''
    return ['/// ' + line for line in code]
