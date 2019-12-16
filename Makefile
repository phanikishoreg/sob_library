.PHONY: all clean dir inpfiles resize lpd cnnface rnface rnface_emb

WCC=clang
#WSYSROOT= --sysroot=/opt/wasi-sdk/share/wasi-sysroot/
WCFLAGS = --target=wasm32-unknown-unknown-wasm -DWASM

CC=clang
CFLAGS= -I. -DCPU_FREQ=2100 -O3
LDFLAGS= -lm

all: clean dir inpfiles resize lpd cnnface rnface #rnface_emb

dir:
	mkdir -p bin/

inpfiles:
	cp samples/*.png samples/*.jpg bin/

resize: samples/resize_image.c
	${CC} ${CFLAGS} samples/resize_image.c sod.c ${LDFLAGS} -o bin/sod_resize
#	${WCC} ${WSYSROOT} ${WCFLAGS} ${CFLAGS} samples/resize_image.c sod.c ${LDFLAGS} -o bin/sod_resize.waout

lpd: samples/license_plate_detection.c
	${CC} ${CFLAGS} samples/license_plate_detection.c sod.c ${LDFLAGS} -o bin/sod_lpd
#	${WCC} ${WSYSROOT} ${WCFLAGS} ${CFLAGS} samples/license_plate_detection.c sod.c ${LDFLAGS} -o bin/sod_lpd.waout

cnnface: samples/cnn_face_detection.c
	${CC} ${CFLAGS} samples/cnn_face_detection.c sod.c ${LDFLAGS} -o bin/sod_cnnface
#	${WCC} ${WSYSROOT} ${WCFLAGS} ${CFLAGS} samples/cnn_face_detection.c sod.c ${LDFLAGS} -o bin/sod_cnnface.waout

rnface: samples/realnet_face_detection.c
	${CC} ${CFLAGS} samples/realnet_face_detection.c sod.c ${LDFLAGS} -o bin/sod_rnface
#	${WCC} ${WSYSROOT} ${WCFLAGS} ${CFLAGS} samples/realnet_face_detection.c sod.c ${LDFLAGS} -o bin/sod_rnface.waout

rnface_emb: samples/realnet_face_detection_embedded.c
	${CC} ${CFLAGS} samples/realnet_face_detection_embedded.c sod.c ${LDFLAGS} -o bin/sod_rnnface_emb


clean:
	rm -rf bin/
