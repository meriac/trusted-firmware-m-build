# Building Trusted Firmware for M-profile Arm CPUs in Docker
 
Build status: [![CircleCI](https://circleci.com/gh/meriac/trusted-firmware-m-build.svg?style=svg)](https://circleci.com/gh/meriac/trusted-firmware-m-build)

See [CircleCI](https://circleci.com/gh/meriac/trusted-firmware-m-build) 
for quick access to build results in the artifacts tab. Please note that *.axf files are in fact *.elf files 0 - feel free to analyse and & dissasemble using arm-none-eabi-objdump in the 
provided docker image.

## Further reading
- MCUBoot [Secure Boot Process](https://github.com/meriac/trusted-firmware-m/blob/master/docs/user_guides/tfm_secure_boot.md)
- [Trusted Firmware for Arm Cortex-M](https://github.com/meriac/trusted-firmware-m/tree/master#trusted-firmware-m---v01)
- Further reading on [MCUboot](https://github.com/runtimeco/mcuboot/blob/master/docs/index.md#mcuboot)

## Manually compiling [trusted-firmware-m](https://github.com/meriac/trusted-firmware-m):

```bash
# Create shared directory between host and docker container, allowing
# you to use your host OS's native text editor for changing tfm code.
mkdir -p shared

# Download and run docker container for building TFM
docker run --rm -ti -v $PWD/shared:/home/build/shared:Z meriac/build-tfm

# Download sources including dependencies
cd shared
git clone --recurse-submodules -j8 https://github.com/meriac/trusted-firmware-m-build

# Build Trusted Firmware for M-profile Arm CPUs
cd trusted-firmware-m-build
make compile

# Show compiled outputs
ls -l build/install/outputs/*
# ... your host directory 'shared' contains now the compiled binaries

# Disassemble one of the compiled files
arm-none-eabi-objdump -d build/install/outputs/AN521/mcuboot.axf | less
```
