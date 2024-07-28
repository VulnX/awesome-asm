# awesome-asm

A minimal multi-threaded web server written in pure assembly which supports file upload/download.

## Compiling

```
➜  ~ nasm -f elf64 web-server.asm
➜  ~ ld -o web-server web-server.o
```

## Usage

```
➜  ~ sudo ./web-server
```

> NOTE : Binding to 0.0.0.0 @ port 80 requires root privileges

## Example

```
➜  ~ curl http://localhost/flag
FAKE{FLAG}
➜  ~ curl -X POST -d 'REAL{FLAG}' http://localhost/flag
➜  ~ curl http://localhost/flag
REAL{FLAG}
➜  ~ 
```

- All files are served relative from the root filesystem `/`.

- By default files upto 1000 bytes can be uploaded/downloaded, however this limit can be increased by modifying the source code to reserve more bytes in `.bss` section
