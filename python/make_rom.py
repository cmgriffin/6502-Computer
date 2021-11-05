file_name = "firmware.bin"

rom = bytearray(0x8000 * [0xEA])

code = """
ADDR=0000
a9 ff; lda 0xff
8d 02 60; sta to address 6002, set DDRB to output
a9 55; lda 0x55
8d 00 60; sta to address 6000, set DDRB to output
a9 aa; lda 0xaa
8d 00 60; sta to address 6000, set DDRB to output
4c 05 80 ; return to start

ADDR=7ffc
00 80 ; reset vector
""".strip().split(
    "\n"
)

# remove blank lines
# remove comments
code = [line.split(";")[0].strip() for line in code if line != ""]
code = " ".join(code).split()
print(code)
current_addr = 0
for data in code:
    if "ADDR" in data:
        current_addr = int(data.split("=")[-1], 16)
        continue
    rom[current_addr] = int(data, 16)
    current_addr += 1

with open(file_name, "wb") as fout:
    fout.write(rom)
print(f"{len(rom)} bytes written to {file_name}")
