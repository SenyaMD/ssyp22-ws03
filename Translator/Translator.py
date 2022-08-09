import sys


class Error(Exception):
    def __init__(self, *args):
        if args:
            self.message = args[0]
        else:
            self.message = None

    def __str__(self):
        if self.message:
            return self.message
        else:
            return 'Error'


system = {'h': 16,
          'b': 2,
          'o': 8,
          'd': 10}


def check(m, res):
    if m[-1].isdigit():  # если последний символ аргумента это цифра
        try:
            res.append(hex(int(m[1:])))  # то преобразовать всё число в 16-ричный вид и добавить в список с результатами
        except ValueError:
            raise Error('No "h" at the end of hex')
    else:  # если последний символ аргумента это не циfra
        try:  # то добавить преобразованное в 16-ричный вид число в список
            res.append(hex(int(m[1:-1], system[m[-1]])))
        except KeyError:  # но если последний символ(буква) аргумента не входит в алфавит 16-ричной СС то выдать ошибку
            raise Error('No "h" at the end of hex')
        except ValueError:
            raise Error('No "h" at the end of hex')
    return res  # если всё хорошо то вернуть результат


def arguments(lis, funct):
    res = []
    for i in lis:  # для каждого элемента списка)
        i = i.lower()
        if '#' in i:  #
            if funct in ['JMP', 'JMPO', 'JMPZ', 'SEI', 'CALL', 'LDRA', 'LDRO', 'STO']:
                raise Error('Unexpected arg')
            else:
                res = check(i, res)
        elif '@' in i:
            if funct in ['ADD', 'AND', 'OR', 'XOR', 'INVB']:
                raise Error('Unexpected arg')
            else:
                res = check(i, res)
        elif i in metki.keys():
            res.append(hex(metki[i]))
        else:
            # res.append(i)
            raise Error('ArgError')
        # res = check(i, res) if ('#' in i) or ('@' in i) else raise Error('ArgError')
    return res
# '/home/ssyp43/Рабочий стол/Text.txt'


def main():
    path = data['-i']   # нужно будет убрать потом.
    path2 = data['-o']
    inp = open(path, 'r', encoding='utf-8')
    o = open(path2, 'w', encoding='utf-8')
    # варианте вместо них путь(относительный) будет вводить пользователь, а открывать начальная функция на 102 строке
    lines, lol = inp.readlines(), []
    inp.close()
    global metki
    func, result, metki, final = ['NOP', 'LDRA', 'LDRO', 'AND', 'OR', 'XOR', 'NOT', 'STO', 'JMP', 'JMPZ', 'JMPO',
                                  'ADD', 'SEI', 'INVB', 'CALL', 'RET'], [], dict(), []
    if data['-f'] == 'logisim':
        final.append('v2.0 raw\n')
    lines = [line.strip() for line in lines]
    metki = {
        'ovf': 0,
        'cmp': 1,
        'int': 2,
        'bnk': 3
    }
    for line in lines:
        if len(line) == 0:
            continue
        else:
            if ';' in line or line == '\n':
                continue
        lol.append(line)
    lines = lol.copy()
    lol.clear()
    for line in lines:
        if ':' in line:
            metki.update({line[:-1]: lines.index(line)})
        else:
            lol.append(line)
    lines = lol
    for line in lines:
        result = []
        try:
            if line.split()[0] in func:
                understandable = line.replace(',', '').split()
                cmmd = understandable[0]
                understandable.remove(understandable[0])
                if len(understandable) > 1:
                    raise Error('More than 1 arg')
                result.extend(arguments(understandable, cmmd))
                result.append(str(hex(func.index(cmmd))))

            else:
                raise Error(f'Unknown CMD: {line.split()[0]}')
        except IndexError:
            pass
        for i in result:
            if int(i, 16) > 255:
                raise Error('Number > 255')
        if len(result) >= 2:
            if int(result[0], 16) > 3 and result[-1] == '0xd':
                raise Error('INVB arg must be less than 3')
            elif result[-1] in ['0x0', '0x6']:
                raise Error(f'Unexpected arg for {func[int(result[-1], 16)]}')
        final.append(''.join(result).replace('0x', '') + '\n')
        final[-1] = '0' * (4 - len(final[-1])) + final[-1]
    o.writelines(final)  # записать результат в выходной файл
    o.close()
    inp.close()
    print('success!')

if __name__ == "__main__":
    sys.tracebacklimit = 0
    argums = sys.argv[0:]
    data = dict()
    if '-h' in argums:
        print('-i {input file} -o {output file} -f {format of file (logisim of clean)}')
    else:
        if '-f' in argums:
            if argums[argums.index('-f') + 1] in ['clean', 'logisim']:
                data.update({'-f': argums[argums.index('-f') + 1]})
            else:
                raise Error('Unexpected Arg for cmd')
        else:
            data.update({'-f': 'clean'})
        if '-i' in argums:
            data.update({'-i': argums[argums.index('-i') + 1]})
        else:
            raise Error('No input file')
        if '-o' in argums:
            data.update({'-o': argums[argums.index('-o') + 1]})
        else:
            raise Error('No output file')
        main()
