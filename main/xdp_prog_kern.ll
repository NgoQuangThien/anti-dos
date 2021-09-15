; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.pkt_meta = type { %union.anon.1, %union.anon.2, [2 x i16], i16, i16, i16, i16, i32 }
%union.anon.1 = type { i32 }
%union.anon.2 = type { i32 }
%struct.hdr_cursor = type { i8* }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.packet_rec = type { i8, i32, i32, i16, [3 x i8], i16, [6 x i8] }
%struct.udphdr = type { i16, i16, i16, i16 }

@xdp_stats_map = global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0 }, section "maps", align 4, !dbg !0
@perf_map = global %struct.bpf_map_def { i32 4, i32 4, i32 4, i32 0, i32 0 }, section "maps", align 4, !dbg !22
@white_list = global %struct.bpf_map_def { i32 5, i32 4, i32 4, i32 10000, i32 1 }, section "maps", align 4, !dbg !34
@black_list = global %struct.bpf_map_def { i32 5, i32 4, i32 4, i32 10000, i32 1 }, section "maps", align 4, !dbg !37
@xdp_parser_func.____fmt = private unnamed_addr constant [38 x i8] c"[PASS] %u ---> %u : IP in WHITE LIST\0A\00", align 1
@xdp_parser_func.____fmt.1 = private unnamed_addr constant [36 x i8] c"[DROP] %u ---> %u IP in BLACK LIST\0A\00", align 1
@_license = global [4 x i8] c"GPL\00", section "license", align 1, !dbg !39
@tcp_stupid.____fmt = private unnamed_addr constant [44 x i8] c"[DROP] %u ---> %u : Fragmented TCP Packets\0A\00", align 1
@icmp_stupid.____fmt = private unnamed_addr constant [45 x i8] c"[DROP] %u ---> %u : Fragmented ICMP Packets\0A\00", align 1
@icmp_stupid.____fmt.2 = private unnamed_addr constant [40 x i8] c"[DROP] %u ---> %u : Large ICMP Packets\0A\00", align 1
@llvm.used = appending global [6 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @black_list to i8*), i8* bitcast (%struct.bpf_map_def* @perf_map to i8*), i8* bitcast (%struct.bpf_map_def* @white_list to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_parser_func to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define i32 @xdp_parser_func(%struct.xdp_md*) #0 section "xdp_packet_parser" !dbg !71 {
  %2 = alloca [44 x i8], align 1
  call void @llvm.dbg.declare(metadata [44 x i8]* %2, metadata !233, metadata !DIExpression()), !dbg !246
  %3 = alloca [45 x i8], align 1
  call void @llvm.dbg.declare(metadata [45 x i8]* %3, metadata !250, metadata !DIExpression()), !dbg !267
  %4 = alloca [40 x i8], align 1
  call void @llvm.dbg.declare(metadata [40 x i8]* %4, metadata !257, metadata !DIExpression()), !dbg !270
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.pkt_meta, align 8
  %9 = alloca [38 x i8], align 1
  %10 = alloca [36 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !83, metadata !DIExpression()), !dbg !271
  %11 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !272
  %12 = load i32, i32* %11, align 4, !dbg !272, !tbaa !273
  %13 = zext i32 %12 to i64, !dbg !278
  %14 = inttoptr i64 %13 to i8*, !dbg !279
  call void @llvm.dbg.value(metadata i8* %14, metadata !84, metadata !DIExpression()), !dbg !280
  %15 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !281
  %16 = load i32, i32* %15, align 4, !dbg !281, !tbaa !282
  %17 = zext i32 %16 to i64, !dbg !283
  %18 = inttoptr i64 %17 to i8*, !dbg !284
  call void @llvm.dbg.value(metadata i8* %18, metadata !85, metadata !DIExpression()), !dbg !285
  call void @llvm.dbg.value(metadata i32 2, metadata !86, metadata !DIExpression()), !dbg !286
  call void @llvm.dbg.value(metadata i32 0, metadata !217, metadata !DIExpression()), !dbg !287
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !87, metadata !DIExpression()), !dbg !288
  call void @llvm.dbg.value(metadata %struct.ethhdr** undef, metadata !92, metadata !DIExpression()), !dbg !289
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !290, metadata !DIExpression()), !dbg !301
  call void @llvm.dbg.value(metadata i8* %14, metadata !297, metadata !DIExpression()), !dbg !303
  call void @llvm.dbg.value(metadata %struct.ethhdr** undef, metadata !298, metadata !DIExpression()), !dbg !304
  call void @llvm.dbg.value(metadata i8* %18, metadata !299, metadata !DIExpression()), !dbg !305
  call void @llvm.dbg.value(metadata i32 14, metadata !300, metadata !DIExpression()), !dbg !306
  %19 = getelementptr i8, i8* %18, i64 14, !dbg !307
  %20 = icmp ugt i8* %19, %14, !dbg !309
  br i1 %20, label %151, label %21, !dbg !310

; <label>:21:                                     ; preds = %1
  %22 = getelementptr inbounds i8, i8* %18, i64 12, !dbg !311
  %23 = bitcast i8* %22 to i16*, !dbg !311
  %24 = load i16, i16* %23, align 1, !dbg !311, !tbaa !312
  %25 = icmp eq i16 %24, 8, !dbg !315
  br i1 %25, label %26, label %151, !dbg !315

; <label>:26:                                     ; preds = %21
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !87, metadata !DIExpression()), !dbg !288
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !316, metadata !DIExpression()), !dbg !326
  call void @llvm.dbg.value(metadata i8* %14, metadata !322, metadata !DIExpression()), !dbg !328
  call void @llvm.dbg.value(metadata i8* %19, metadata !324, metadata !DIExpression()), !dbg !329
  %27 = getelementptr inbounds i8, i8* %18, i64 34, !dbg !330
  %28 = icmp ugt i8* %27, %14, !dbg !332
  br i1 %28, label %151, label %29, !dbg !333

; <label>:29:                                     ; preds = %26
  %30 = load i8, i8* %19, align 4, !dbg !334
  %31 = shl i8 %30, 2, !dbg !335
  %32 = and i8 %31, 60, !dbg !335
  %33 = icmp ult i8 %32, 20, !dbg !336
  br i1 %33, label %151, label %34, !dbg !338

; <label>:34:                                     ; preds = %29
  %35 = zext i8 %32 to i64, !dbg !339
  %36 = getelementptr i8, i8* %19, i64 %35, !dbg !340
  %37 = icmp ugt i8* %36, %14, !dbg !342
  br i1 %37, label %151, label %38, !dbg !343

; <label>:38:                                     ; preds = %34
  %39 = getelementptr inbounds i8, i8* %18, i64 23, !dbg !344
  %40 = load i8, i8* %39, align 1, !dbg !344, !tbaa !345
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %41 = getelementptr inbounds i8, i8* %18, i64 26, !dbg !348
  %42 = bitcast i8* %41 to i32*, !dbg !348
  %43 = load i32, i32* %42, align 4, !dbg !348, !tbaa !349
  %44 = bitcast i32* %6 to i8*, !dbg !350
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %44), !dbg !350
  call void @llvm.dbg.value(metadata i32 %43, metadata !355, metadata !DIExpression()) #3, !dbg !350
  store i32 %43, i32* %6, align 4, !tbaa !357
  %45 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @white_list to i8*), i8* nonnull %44) #3, !dbg !358
  %46 = icmp eq i8* %45, null, !dbg !358
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %44), !dbg !360
  br i1 %46, label %52, label %47, !dbg !361

; <label>:47:                                     ; preds = %38
  %48 = getelementptr inbounds [38 x i8], [38 x i8]* %9, i64 0, i64 0, !dbg !362
  call void @llvm.lifetime.start.p0i8(i64 38, i8* nonnull %48) #3, !dbg !362
  call void @llvm.dbg.declare(metadata [38 x i8]* %9, metadata !218, metadata !DIExpression()), !dbg !362
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %48, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @xdp_parser_func.____fmt, i64 0, i64 0), i64 38, i32 1, i1 false), !dbg !362
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %49 = load i32, i32* %42, align 4, !dbg !362, !tbaa !349
  %50 = call i32 @llvm.bswap.i32(i32 %49), !dbg !362
  %51 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %48, i32 38, i32 %50, i32 %50) #3, !dbg !362
  call void @llvm.lifetime.end.p0i8(i64 38, i8* nonnull %48) #3, !dbg !363
  call void @llvm.dbg.value(metadata i32 2, metadata !86, metadata !DIExpression()), !dbg !286
  br label %151, !dbg !364

; <label>:52:                                     ; preds = %38
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %53 = load i32, i32* %42, align 4, !dbg !365, !tbaa !349
  %54 = bitcast i32* %5 to i8*, !dbg !366
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %54), !dbg !366
  call void @llvm.dbg.value(metadata i32 %53, metadata !369, metadata !DIExpression()) #3, !dbg !366
  store i32 %53, i32* %5, align 4, !tbaa !357
  %55 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @black_list to i8*), i8* nonnull %54) #3, !dbg !371
  %56 = icmp eq i8* %55, null, !dbg !371
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %54), !dbg !373
  br i1 %56, label %62, label %57, !dbg !374

; <label>:57:                                     ; preds = %52
  %58 = getelementptr inbounds [36 x i8], [36 x i8]* %10, i64 0, i64 0, !dbg !375
  call void @llvm.lifetime.start.p0i8(i64 36, i8* nonnull %58) #3, !dbg !375
  call void @llvm.dbg.declare(metadata [36 x i8]* %10, metadata !226, metadata !DIExpression()), !dbg !375
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %58, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @xdp_parser_func.____fmt.1, i64 0, i64 0), i64 36, i32 1, i1 false), !dbg !375
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %59 = load i32, i32* %42, align 4, !dbg !375, !tbaa !349
  %60 = call i32 @llvm.bswap.i32(i32 %59), !dbg !375
  %61 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %58, i32 36, i32 %60, i32 %60) #3, !dbg !375
  call void @llvm.lifetime.end.p0i8(i64 36, i8* nonnull %58) #3, !dbg !376
  call void @llvm.dbg.value(metadata i32 1, metadata !86, metadata !DIExpression()), !dbg !286
  br label %151, !dbg !377

; <label>:62:                                     ; preds = %52
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %63 = load i32, i32* %42, align 4, !dbg !378, !tbaa !349
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %64 = getelementptr inbounds i8, i8* %18, i64 30, !dbg !379
  %65 = bitcast i8* %64 to i32*, !dbg !379
  %66 = load i32, i32* %65, align 4, !dbg !379, !tbaa !380
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %67 = getelementptr inbounds i8, i8* %18, i64 16, !dbg !381
  %68 = bitcast i8* %67 to i16*, !dbg !381
  %69 = load i16, i16* %68, align 2, !dbg !381, !tbaa !382
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %70 = getelementptr inbounds i8, i8* %18, i64 20, !dbg !383
  %71 = bitcast i8* %70 to i16*, !dbg !383
  %72 = load i16, i16* %71, align 2, !dbg !383, !tbaa !384
  switch i8 %40, label %151 [
    i8 6, label %73
    i8 17, label %107
    i8 1, label %124
  ], !dbg !385

; <label>:73:                                     ; preds = %62
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !87, metadata !DIExpression()), !dbg !288
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !386, metadata !DIExpression()), !dbg !396
  call void @llvm.dbg.value(metadata i8* %14, metadata !392, metadata !DIExpression()), !dbg !400
  call void @llvm.dbg.value(metadata i8* %36, metadata !395, metadata !DIExpression()), !dbg !401
  %74 = getelementptr inbounds i8, i8* %36, i64 20, !dbg !402
  %75 = icmp ugt i8* %74, %14, !dbg !404
  br i1 %75, label %151, label %76, !dbg !405

; <label>:76:                                     ; preds = %73
  %77 = getelementptr inbounds i8, i8* %36, i64 12, !dbg !406
  %78 = bitcast i8* %77 to i16*, !dbg !406
  %79 = load i16, i16* %78, align 4, !dbg !406
  %80 = lshr i16 %79, 2, !dbg !407
  %81 = and i16 %80, 60, !dbg !407
  %82 = icmp ult i16 %81, 20, !dbg !408
  br i1 %82, label %151, label %83, !dbg !410

; <label>:83:                                     ; preds = %76
  %84 = zext i16 %81 to i64, !dbg !411
  %85 = getelementptr i8, i8* %36, i64 %84, !dbg !412
  %86 = icmp ugt i8* %85, %14, !dbg !414
  br i1 %86, label %151, label %87, !dbg !415

; <label>:87:                                     ; preds = %83
  call void @llvm.dbg.value(metadata i8* %36, metadata !125, metadata !DIExpression()), !dbg !416
  call void @llvm.dbg.value(metadata %struct.packet_rec* undef, metadata !180, metadata !DIExpression()), !dbg !417
  call void @llvm.dbg.value(metadata i32 %63, metadata !242, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !418
  call void @llvm.dbg.value(metadata i32 %66, metadata !242, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !418
  call void @llvm.dbg.value(metadata i16 %69, metadata !242, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 16)), !dbg !418
  call void @llvm.dbg.value(metadata i32 0, metadata !242, metadata !DIExpression(DW_OP_LLVM_fragment, 112, 32)), !dbg !418
  call void @llvm.dbg.value(metadata i16 %72, metadata !242, metadata !DIExpression(DW_OP_LLVM_fragment, 144, 16)), !dbg !418
  call void @llvm.dbg.value(metadata i32 0, metadata !242, metadata !DIExpression(DW_OP_LLVM_fragment, 160, 32)), !dbg !418
  call void @llvm.dbg.value(metadata i16 %72, metadata !419, metadata !DIExpression()) #3, !dbg !425
  %88 = and i16 %72, -193, !dbg !427
  %89 = icmp eq i16 %88, 0, !dbg !427
  %90 = and i16 %79, 512, !dbg !429
  %91 = icmp eq i16 %90, 0, !dbg !429
  %92 = or i1 %89, %91, !dbg !430
  br i1 %92, label %98, label %93, !dbg !431

; <label>:93:                                     ; preds = %87
  %94 = getelementptr inbounds [44 x i8], [44 x i8]* %2, i64 0, i64 0, !dbg !246
  call void @llvm.lifetime.start.p0i8(i64 44, i8* nonnull %94) #3, !dbg !246
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %94, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @tcp_stupid.____fmt, i64 0, i64 0), i64 44, i32 1, i1 false) #3, !dbg !246
  %95 = call i32 @llvm.bswap.i32(i32 %63) #3, !dbg !246
  %96 = call i32 @llvm.bswap.i32(i32 %66) #3, !dbg !246
  %97 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %94, i32 44, i32 %95, i32 %96) #3, !dbg !246
  call void @llvm.lifetime.end.p0i8(i64 44, i8* nonnull %94) #3, !dbg !432
  br label %151, !dbg !433

; <label>:98:                                     ; preds = %87
  call void @llvm.dbg.value(metadata i32 20, metadata !217, metadata !DIExpression()), !dbg !287
  call void @llvm.dbg.value(metadata i8* %36, metadata !125, metadata !DIExpression()), !dbg !416
  %99 = bitcast i8* %36 to i16*, !dbg !434
  %100 = load i16, i16* %99, align 4, !dbg !434, !tbaa !435
  call void @llvm.dbg.value(metadata i8* %36, metadata !125, metadata !DIExpression()), !dbg !416
  %101 = getelementptr inbounds i8, i8* %36, i64 2, !dbg !437
  %102 = bitcast i8* %101 to i16*, !dbg !437
  %103 = load i16, i16* %102, align 2, !dbg !437, !tbaa !438
  call void @llvm.dbg.value(metadata i8* %36, metadata !125, metadata !DIExpression()), !dbg !416
  %104 = getelementptr inbounds i8, i8* %36, i64 4, !dbg !439
  %105 = bitcast i8* %104 to i32*, !dbg !439
  %106 = load i32, i32* %105, align 4, !dbg !439, !tbaa !440
  br label %140, !dbg !441

; <label>:107:                                    ; preds = %62
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !87, metadata !DIExpression()), !dbg !288
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !442, metadata !DIExpression()) #3, !dbg !452
  call void @llvm.dbg.value(metadata i8* %14, metadata !448, metadata !DIExpression()) #3, !dbg !456
  call void @llvm.dbg.value(metadata i8* %36, metadata !451, metadata !DIExpression()) #3, !dbg !457
  %108 = getelementptr inbounds i8, i8* %36, i64 8, !dbg !458
  %109 = bitcast i8* %108 to %struct.udphdr*, !dbg !458
  %110 = inttoptr i64 %13 to %struct.udphdr*, !dbg !460
  %111 = icmp ugt %struct.udphdr* %109, %110, !dbg !461
  br i1 %111, label %151, label %112, !dbg !462

; <label>:112:                                    ; preds = %107
  %113 = getelementptr inbounds i8, i8* %36, i64 4, !dbg !463
  %114 = bitcast i8* %113 to i16*, !dbg !463
  %115 = load i16, i16* %114, align 2, !dbg !463, !tbaa !464
  %116 = call i16 @llvm.bswap.i16(i16 %115) #3, !dbg !463
  %117 = icmp ult i16 %116, 8, !dbg !466
  br i1 %117, label %151, label %118, !dbg !468

; <label>:118:                                    ; preds = %112
  call void @llvm.dbg.value(metadata i32 8, metadata !217, metadata !DIExpression()), !dbg !287
  call void @llvm.dbg.value(metadata i8* %36, metadata !147, metadata !DIExpression()), !dbg !469
  %119 = bitcast i8* %36 to i16*, !dbg !470
  %120 = load i16, i16* %119, align 2, !dbg !470, !tbaa !471
  call void @llvm.dbg.value(metadata i8* %36, metadata !147, metadata !DIExpression()), !dbg !469
  %121 = getelementptr inbounds i8, i8* %36, i64 2, !dbg !472
  %122 = bitcast i8* %121 to i16*, !dbg !472
  %123 = load i16, i16* %122, align 2, !dbg !472, !tbaa !473
  br label %140, !dbg !474

; <label>:124:                                    ; preds = %62
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !87, metadata !DIExpression()), !dbg !288
  call void @llvm.dbg.value(metadata %struct.packet_rec* undef, metadata !180, metadata !DIExpression()), !dbg !417
  call void @llvm.dbg.value(metadata i32 %63, metadata !256, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 32)), !dbg !475
  call void @llvm.dbg.value(metadata i32 %66, metadata !256, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !475
  call void @llvm.dbg.value(metadata i16 %69, metadata !256, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 16)), !dbg !475
  call void @llvm.dbg.value(metadata i32 0, metadata !256, metadata !DIExpression(DW_OP_LLVM_fragment, 112, 32)), !dbg !475
  call void @llvm.dbg.value(metadata i16 %72, metadata !256, metadata !DIExpression(DW_OP_LLVM_fragment, 144, 16)), !dbg !475
  call void @llvm.dbg.value(metadata i32 0, metadata !256, metadata !DIExpression(DW_OP_LLVM_fragment, 160, 32)), !dbg !475
  call void @llvm.dbg.value(metadata i8 0, metadata !256, metadata !DIExpression(DW_OP_LLVM_fragment, 192, 8)), !dbg !475
  call void @llvm.dbg.value(metadata i16 %72, metadata !476, metadata !DIExpression()) #3, !dbg !481
  %125 = and i16 %72, -193, !dbg !483
  %126 = icmp eq i16 %125, 0, !dbg !483
  br i1 %126, label %132, label %127, !dbg !485

; <label>:127:                                    ; preds = %124
  %128 = getelementptr inbounds [45 x i8], [45 x i8]* %3, i64 0, i64 0, !dbg !267
  call void @llvm.lifetime.start.p0i8(i64 45, i8* nonnull %128) #3, !dbg !267
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %128, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @icmp_stupid.____fmt, i64 0, i64 0), i64 45, i32 1, i1 false) #3, !dbg !267
  %129 = call i32 @llvm.bswap.i32(i32 %63) #3, !dbg !267
  %130 = call i32 @llvm.bswap.i32(i32 %66) #3, !dbg !267
  %131 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %128, i32 45, i32 %129, i32 %130) #3, !dbg !267
  call void @llvm.lifetime.end.p0i8(i64 45, i8* nonnull %128) #3, !dbg !486
  br label %151, !dbg !487

; <label>:132:                                    ; preds = %124
  call void @llvm.dbg.value(metadata i16 %69, metadata !488, metadata !DIExpression()) #3, !dbg !491
  %133 = call i16 @llvm.bswap.i16(i16 %69) #3, !dbg !493
  %134 = icmp ult i16 %133, 1025, !dbg !495
  br i1 %134, label %140, label %135, !dbg !496

; <label>:135:                                    ; preds = %132
  %136 = getelementptr inbounds [40 x i8], [40 x i8]* %4, i64 0, i64 0, !dbg !270
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %136) #3, !dbg !270
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull %136, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @icmp_stupid.____fmt.2, i64 0, i64 0), i64 40, i32 1, i1 false) #3, !dbg !270
  %137 = call i32 @llvm.bswap.i32(i32 %63) #3, !dbg !270
  %138 = call i32 @llvm.bswap.i32(i32 %66) #3, !dbg !270
  %139 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %136, i32 40, i32 %137, i32 %138) #3, !dbg !270
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %136) #3, !dbg !497
  br label %151, !dbg !498

; <label>:140:                                    ; preds = %132, %98, %118
  %141 = phi i16 [ %120, %118 ], [ %100, %98 ], [ 0, %132 ]
  %142 = phi i16 [ %123, %118 ], [ %103, %98 ], [ 0, %132 ]
  %143 = phi i32 [ 0, %118 ], [ %106, %98 ], [ 0, %132 ]
  %144 = phi i64 [ 42, %118 ], [ 54, %98 ], [ 42, %132 ]
  %145 = sub nsw i64 %13, %17, !dbg !499
  %146 = trunc i64 %145 to i16, !dbg !500
  %147 = sub nsw i64 %145, %144, !dbg !501
  %148 = trunc i64 %147 to i16, !dbg !502
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  call void @llvm.dbg.value(metadata i8* %19, metadata !106, metadata !DIExpression()), !dbg !347
  %149 = load i8, i8* %39, align 1, !dbg !503, !tbaa !345
  %150 = zext i8 %149 to i16, !dbg !504
  br label %151, !dbg !505

; <label>:151:                                    ; preds = %135, %127, %112, %107, %83, %76, %73, %34, %29, %26, %1, %93, %21, %62, %140, %57, %47
  %152 = phi i16 [ 0, %62 ], [ %141, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %153 = phi i16 [ 0, %62 ], [ %142, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %154 = phi i16 [ 0, %62 ], [ 2048, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %155 = phi i16 [ 0, %62 ], [ %150, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %156 = phi i16 [ 0, %62 ], [ %148, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %157 = phi i16 [ 0, %62 ], [ %146, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %158 = phi i32 [ 0, %62 ], [ %143, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %159 = phi i32 [ 0, %62 ], [ %66, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %160 = phi i32 [ 0, %62 ], [ %63, %140 ], [ 0, %93 ], [ 0, %57 ], [ 0, %47 ], [ 0, %21 ], [ 0, %1 ], [ 0, %26 ], [ 0, %29 ], [ 0, %34 ], [ 0, %73 ], [ 0, %76 ], [ 0, %83 ], [ 0, %107 ], [ 0, %112 ], [ 0, %127 ], [ 0, %135 ]
  %161 = phi i32 [ 2, %62 ], [ 2, %140 ], [ 1, %93 ], [ 1, %57 ], [ 2, %47 ], [ 2, %21 ], [ 1, %1 ], [ 1, %26 ], [ 1, %29 ], [ 1, %34 ], [ 1, %73 ], [ 1, %76 ], [ 1, %83 ], [ 1, %107 ], [ 1, %112 ], [ 1, %127 ], [ 1, %135 ]
  call void @llvm.dbg.value(metadata i32 %161, metadata !86, metadata !DIExpression()), !dbg !286
  call void @llvm.dbg.value(metadata %struct.pkt_meta* undef, metadata !195, metadata !DIExpression()), !dbg !506
  %162 = bitcast %struct.pkt_meta* %8 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %162)
  %163 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %163)
  %164 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 0, i32 0
  store i32 %160, i32* %164, align 8
  %165 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 1, i32 0
  store i32 %159, i32* %165, align 4
  %166 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 2, i64 0
  store i16 %152, i16* %166, align 8
  %167 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 2, i64 1
  store i16 %153, i16* %167, align 2
  %168 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 3
  store i16 %154, i16* %168, align 4
  %169 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 4
  store i16 %155, i16* %169, align 2
  %170 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 5
  store i16 %156, i16* %170, align 8
  %171 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 6
  store i16 %157, i16* %171, align 2
  %172 = getelementptr inbounds %struct.pkt_meta, %struct.pkt_meta* %8, i64 0, i32 7
  store i32 %158, i32* %172, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !507, metadata !DIExpression()) #3, !dbg !521
  call void @llvm.dbg.value(metadata i32 %161, metadata !512, metadata !DIExpression()) #3, !dbg !523
  store i32 %161, i32* %7, align 4, !tbaa !357
  %173 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %163) #3, !dbg !524
  call void @llvm.dbg.value(metadata i8* %173, metadata !514, metadata !DIExpression()) #3, !dbg !525
  %174 = icmp eq i8* %173, null, !dbg !526
  br i1 %174, label %196, label %175, !dbg !528

; <label>:175:                                    ; preds = %151
  %176 = bitcast i8* %173 to i64*, !dbg !529
  %177 = load i64, i64* %176, align 8, !dbg !530, !tbaa !531
  %178 = add i64 %177, 1, !dbg !530
  store i64 %178, i64* %176, align 8, !dbg !530, !tbaa !531
  %179 = load i32, i32* %11, align 4, !dbg !534, !tbaa !273
  %180 = load i32, i32* %15, align 4, !dbg !535, !tbaa !282
  %181 = sub i32 %179, %180, !dbg !536
  %182 = zext i32 %181 to i64, !dbg !537
  %183 = getelementptr inbounds i8, i8* %173, i64 8, !dbg !538
  %184 = bitcast i8* %183 to i64*, !dbg !538
  %185 = load i64, i64* %184, align 8, !dbg !539, !tbaa !540
  %186 = add i64 %185, %182, !dbg !539
  store i64 %186, i64* %184, align 8, !dbg !539, !tbaa !540
  %187 = load i32, i32* %7, align 4, !dbg !541, !tbaa !357
  call void @llvm.dbg.value(metadata i32 %187, metadata !512, metadata !DIExpression()) #3, !dbg !523
  %188 = icmp eq i32 %187, 2, !dbg !543
  br i1 %188, label %189, label %196, !dbg !544

; <label>:189:                                    ; preds = %175
  %190 = bitcast %struct.xdp_md* %0 to i8*, !dbg !545
  %191 = zext i16 %157 to i64, !dbg !546
  %192 = shl nuw nsw i64 %191, 32, !dbg !547
  %193 = or i64 %192, 4294967295, !dbg !548
  %194 = call i32 inttoptr (i64 25 to i32 (i8*, i8*, i64, i8*, i64)*)(i8* %190, i8* bitcast (%struct.bpf_map_def* @perf_map to i8*), i64 %193, i8* nonnull %162, i64 24) #3, !dbg !549
  %195 = load i32, i32* %7, align 4, !dbg !550, !tbaa !357
  br label %196, !dbg !549

; <label>:196:                                    ; preds = %151, %175, %189
  %197 = phi i32 [ 0, %151 ], [ %187, %175 ], [ %195, %189 ]
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %162), !dbg !551
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %163), !dbg !551
  ret i32 %197, !dbg !552
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: nounwind readnone speculatable
declare i32 @llvm.bswap.i32(i32) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!67, !68, !69}
!llvm.ident = !{!70}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !24, line: 15, type: !25, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !13, globals: !21)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/server/git/anti-dos/main")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, size: 32, elements: !7)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/server/git/anti-dos/main")
!7 = !{!8, !9, !10, !11, !12}
!8 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!9 = !DIEnumerator(name: "XDP_DROP", value: 1)
!10 = !DIEnumerator(name: "XDP_PASS", value: 2)
!11 = !DIEnumerator(name: "XDP_TX", value: 3)
!12 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!13 = !{!14, !15, !16, !19}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!15 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !17, line: 24, baseType: !18)
!17 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "/home/server/git/anti-dos/main")
!18 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !17, line: 31, baseType: !20)
!20 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!21 = !{!0, !22, !34, !37, !39, !45, !53, !62}
!22 = !DIGlobalVariableExpression(var: !23, expr: !DIExpression())
!23 = distinct !DIGlobalVariable(name: "perf_map", scope: !2, file: !24, line: 22, type: !25, isLocal: false, isDefinition: true)
!24 = !DIFile(filename: "./common/xdp_stats_kern.h", directory: "/home/server/git/anti-dos/main")
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !26, line: 33, size: 160, elements: !27)
!26 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/home/server/git/anti-dos/main")
!27 = !{!28, !30, !31, !32, !33}
!28 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !25, file: !26, line: 34, baseType: !29, size: 32)
!29 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !25, file: !26, line: 35, baseType: !29, size: 32, offset: 32)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !25, file: !26, line: 36, baseType: !29, size: 32, offset: 64)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !25, file: !26, line: 37, baseType: !29, size: 32, offset: 96)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !25, file: !26, line: 38, baseType: !29, size: 32, offset: 128)
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(name: "white_list", scope: !2, file: !36, line: 8, type: !25, isLocal: false, isDefinition: true)
!36 = !DIFile(filename: "./common/map_define.h", directory: "/home/server/git/anti-dos/main")
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "black_list", scope: !2, file: !36, line: 16, type: !25, isLocal: false, isDefinition: true)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 149, type: !41, isLocal: false, isDefinition: true)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 32, elements: !43)
!42 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!43 = !{!44}
!44 = !DISubrange(count: 4)
!45 = !DIGlobalVariableExpression(var: !46, expr: !DIExpression())
!46 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !47, line: 33, type: !48, isLocal: true, isDefinition: true)
!47 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/server/git/anti-dos/main")
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = !DISubroutineType(types: !50)
!50 = !{!14, !14, !51}
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !47, line: 152, type: !55, isLocal: true, isDefinition: true)
!55 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !56, size: 64)
!56 = !DISubroutineType(types: !57)
!57 = !{!58, !59, !61, null}
!58 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !42)
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !17, line: 27, baseType: !29)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression())
!63 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !2, file: !47, line: 666, type: !64, isLocal: true, isDefinition: true)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = !DISubroutineType(types: !66)
!66 = !{!58, !14, !14, !19, !14, !19}
!67 = !{i32 2, !"Dwarf Version", i32 4}
!68 = !{i32 2, !"Debug Info Version", i32 3}
!69 = !{i32 1, !"wchar_size", i32 4}
!70 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
!71 = distinct !DISubprogram(name: "xdp_parser_func", scope: !3, file: !3, line: 28, type: !72, isLocal: false, isDefinition: true, scopeLine: 29, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !82)
!72 = !DISubroutineType(types: !73)
!73 = !{!58, !74}
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !76)
!76 = !{!77, !78, !79, !80, !81}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !75, file: !6, line: 2857, baseType: !61, size: 32)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !75, file: !6, line: 2858, baseType: !61, size: 32, offset: 32)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !75, file: !6, line: 2859, baseType: !61, size: 32, offset: 64)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !75, file: !6, line: 2861, baseType: !61, size: 32, offset: 96)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !75, file: !6, line: 2862, baseType: !61, size: 32, offset: 128)
!82 = !{!83, !84, !85, !86, !87, !92, !106, !125, !147, !156, !180, !195, !215, !216, !217, !218, !226}
!83 = !DILocalVariable(name: "ctx", arg: 1, scope: !71, file: !3, line: 28, type: !74)
!84 = !DILocalVariable(name: "data_end", scope: !71, file: !3, line: 30, type: !14)
!85 = !DILocalVariable(name: "data", scope: !71, file: !3, line: 31, type: !14)
!86 = !DILocalVariable(name: "action", scope: !71, file: !3, line: 33, type: !61)
!87 = !DILocalVariable(name: "nh", scope: !71, file: !3, line: 35, type: !88)
!88 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !89, line: 12, size: 64, elements: !90)
!89 = !DIFile(filename: "./common/parsing.h", directory: "/home/server/git/anti-dos/main")
!90 = !{!91}
!91 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !88, file: !89, line: 13, baseType: !14, size: 64)
!92 = !DILocalVariable(name: "eth", scope: !71, file: !3, line: 38, type: !93)
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !94, size: 64)
!94 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !95, line: 159, size: 112, elements: !96)
!95 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "/home/server/git/anti-dos/main")
!96 = !{!97, !102, !103}
!97 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !94, file: !95, line: 160, baseType: !98, size: 48)
!98 = !DICompositeType(tag: DW_TAG_array_type, baseType: !99, size: 48, elements: !100)
!99 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!100 = !{!101}
!101 = !DISubrange(count: 6)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !94, file: !95, line: 161, baseType: !98, size: 48, offset: 48)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !94, file: !95, line: 162, baseType: !104, size: 16, offset: 96)
!104 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !105, line: 25, baseType: !16)
!105 = !DIFile(filename: "/usr/include/linux/types.h", directory: "/home/server/git/anti-dos/main")
!106 = !DILocalVariable(name: "iphdr", scope: !71, file: !3, line: 39, type: !107)
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!108 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !109, line: 86, size: 160, elements: !110)
!109 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "/home/server/git/anti-dos/main")
!110 = !{!111, !113, !114, !115, !116, !117, !118, !119, !120, !122, !124}
!111 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !108, file: !109, line: 88, baseType: !112, size: 4, flags: DIFlagBitField, extraData: i64 0)
!112 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !17, line: 21, baseType: !99)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !108, file: !109, line: 89, baseType: !112, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !108, file: !109, line: 96, baseType: !112, size: 8, offset: 8)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !108, file: !109, line: 97, baseType: !104, size: 16, offset: 16)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !108, file: !109, line: 98, baseType: !104, size: 16, offset: 32)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !108, file: !109, line: 99, baseType: !104, size: 16, offset: 48)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !108, file: !109, line: 100, baseType: !112, size: 8, offset: 64)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !108, file: !109, line: 101, baseType: !112, size: 8, offset: 72)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !108, file: !109, line: 102, baseType: !121, size: 16, offset: 80)
!121 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !105, line: 31, baseType: !16)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !108, file: !109, line: 103, baseType: !123, size: 32, offset: 96)
!123 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !105, line: 27, baseType: !61)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !108, file: !109, line: 104, baseType: !123, size: 32, offset: 128)
!125 = !DILocalVariable(name: "tcphdr", scope: !71, file: !3, line: 40, type: !126)
!126 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !127, size: 64)
!127 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !128, line: 25, size: 160, elements: !129)
!128 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "/home/server/git/anti-dos/main")
!129 = !{!130, !131, !132, !133, !134, !135, !136, !137, !138, !139, !140, !141, !142, !143, !144, !145, !146}
!130 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !127, file: !128, line: 26, baseType: !104, size: 16)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !127, file: !128, line: 27, baseType: !104, size: 16, offset: 16)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !127, file: !128, line: 28, baseType: !123, size: 32, offset: 32)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !127, file: !128, line: 29, baseType: !123, size: 32, offset: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !127, file: !128, line: 31, baseType: !16, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !127, file: !128, line: 32, baseType: !16, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !127, file: !128, line: 33, baseType: !16, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !127, file: !128, line: 34, baseType: !16, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !127, file: !128, line: 35, baseType: !16, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !127, file: !128, line: 36, baseType: !16, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !127, file: !128, line: 37, baseType: !16, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !127, file: !128, line: 38, baseType: !16, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !127, file: !128, line: 39, baseType: !16, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !127, file: !128, line: 40, baseType: !16, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !127, file: !128, line: 55, baseType: !104, size: 16, offset: 112)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !127, file: !128, line: 56, baseType: !121, size: 16, offset: 128)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !127, file: !128, line: 57, baseType: !104, size: 16, offset: 144)
!147 = !DILocalVariable(name: "udphdr", scope: !71, file: !3, line: 41, type: !148)
!148 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !149, size: 64)
!149 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !150, line: 23, size: 64, elements: !151)
!150 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "/home/server/git/anti-dos/main")
!151 = !{!152, !153, !154, !155}
!152 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !149, file: !150, line: 24, baseType: !104, size: 16)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !149, file: !150, line: 25, baseType: !104, size: 16, offset: 16)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !149, file: !150, line: 26, baseType: !104, size: 16, offset: 32)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !149, file: !150, line: 27, baseType: !121, size: 16, offset: 48)
!156 = !DILocalVariable(name: "icmphdr", scope: !71, file: !3, line: 42, type: !157)
!157 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !158, size: 64)
!158 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmphdr", file: !159, line: 69, size: 64, elements: !160)
!159 = !DIFile(filename: "/usr/include/linux/icmp.h", directory: "/home/server/git/anti-dos/main")
!160 = !{!161, !162, !163, !164}
!161 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !158, file: !159, line: 70, baseType: !112, size: 8)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "code", scope: !158, file: !159, line: 71, baseType: !112, size: 8, offset: 8)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "checksum", scope: !158, file: !159, line: 72, baseType: !121, size: 16, offset: 16)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "un", scope: !158, file: !159, line: 84, baseType: !165, size: 32, offset: 32)
!165 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !158, file: !159, line: 73, size: 32, elements: !166)
!166 = !{!167, !172, !173, !178}
!167 = !DIDerivedType(tag: DW_TAG_member, name: "echo", scope: !165, file: !159, line: 77, baseType: !168, size: 32)
!168 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !165, file: !159, line: 74, size: 32, elements: !169)
!169 = !{!170, !171}
!170 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !168, file: !159, line: 75, baseType: !104, size: 16)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "sequence", scope: !168, file: !159, line: 76, baseType: !104, size: 16, offset: 16)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "gateway", scope: !165, file: !159, line: 78, baseType: !123, size: 32)
!173 = !DIDerivedType(tag: DW_TAG_member, name: "frag", scope: !165, file: !159, line: 82, baseType: !174, size: 32)
!174 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !165, file: !159, line: 79, size: 32, elements: !175)
!175 = !{!176, !177}
!176 = !DIDerivedType(tag: DW_TAG_member, name: "__unused", scope: !174, file: !159, line: 80, baseType: !104, size: 16)
!177 = !DIDerivedType(tag: DW_TAG_member, name: "mtu", scope: !174, file: !159, line: 81, baseType: !104, size: 16, offset: 16)
!178 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", scope: !165, file: !159, line: 83, baseType: !179, size: 32)
!179 = !DICompositeType(tag: DW_TAG_array_type, baseType: !112, size: 32, elements: !43)
!180 = !DILocalVariable(name: "pkt", scope: !71, file: !3, line: 44, type: !181)
!181 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "packet_rec", file: !182, line: 5, size: 224, elements: !183)
!182 = !DIFile(filename: "./common/policy_struct_kern_user.h", directory: "/home/server/git/anti-dos/main")
!183 = !{!184, !185, !186, !187, !188, !192, !193}
!184 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !181, file: !182, line: 6, baseType: !112, size: 8)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "src_addr", scope: !181, file: !182, line: 7, baseType: !61, size: 32, offset: 32)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "dest_addr", scope: !181, file: !182, line: 8, baseType: !61, size: 32, offset: 64)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !181, file: !182, line: 9, baseType: !16, size: 16, offset: 96)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "ip_flags", scope: !181, file: !182, line: 10, baseType: !189, size: 24, offset: 112)
!189 = !DICompositeType(tag: DW_TAG_array_type, baseType: !112, size: 24, elements: !190)
!190 = !{!191}
!191 = !DISubrange(count: 3)
!192 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !181, file: !182, line: 11, baseType: !16, size: 16, offset: 144)
!193 = !DIDerivedType(tag: DW_TAG_member, name: "tcp_flags", scope: !181, file: !182, line: 12, baseType: !194, size: 48, offset: 160)
!194 = !DICompositeType(tag: DW_TAG_array_type, baseType: !112, size: 48, elements: !100)
!195 = !DILocalVariable(name: "pkt_meta", scope: !71, file: !3, line: 45, type: !196)
!196 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "pkt_meta", file: !182, line: 16, size: 192, elements: !197)
!197 = !{!198, !202, !206, !210, !211, !212, !213, !214}
!198 = !DIDerivedType(tag: DW_TAG_member, scope: !196, file: !182, line: 17, baseType: !199, size: 32)
!199 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !196, file: !182, line: 17, size: 32, elements: !200)
!200 = !{!201}
!201 = !DIDerivedType(tag: DW_TAG_member, name: "src", scope: !199, file: !182, line: 18, baseType: !123, size: 32)
!202 = !DIDerivedType(tag: DW_TAG_member, scope: !196, file: !182, line: 20, baseType: !203, size: 32, offset: 32)
!203 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !196, file: !182, line: 20, size: 32, elements: !204)
!204 = !{!205}
!205 = !DIDerivedType(tag: DW_TAG_member, name: "dst", scope: !203, file: !182, line: 21, baseType: !123, size: 32)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "port16", scope: !196, file: !182, line: 23, baseType: !207, size: 32, offset: 64)
!207 = !DICompositeType(tag: DW_TAG_array_type, baseType: !16, size: 32, elements: !208)
!208 = !{!209}
!209 = !DISubrange(count: 2)
!210 = !DIDerivedType(tag: DW_TAG_member, name: "l3_proto", scope: !196, file: !182, line: 24, baseType: !16, size: 16, offset: 96)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "l4_proto", scope: !196, file: !182, line: 25, baseType: !16, size: 16, offset: 112)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "data_len", scope: !196, file: !182, line: 26, baseType: !16, size: 16, offset: 128)
!213 = !DIDerivedType(tag: DW_TAG_member, name: "pkt_len", scope: !196, file: !182, line: 27, baseType: !16, size: 16, offset: 144)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !196, file: !182, line: 28, baseType: !61, size: 32, offset: 160)
!215 = !DILocalVariable(name: "eth_type", scope: !71, file: !3, line: 46, type: !58)
!216 = !DILocalVariable(name: "ip_type", scope: !71, file: !3, line: 47, type: !58)
!217 = !DILocalVariable(name: "off", scope: !71, file: !3, line: 48, type: !61)
!218 = !DILocalVariable(name: "____fmt", scope: !219, file: !3, line: 64, type: !223)
!219 = distinct !DILexicalBlock(scope: !220, file: !3, line: 64, column: 5)
!220 = distinct !DILexicalBlock(scope: !221, file: !3, line: 63, column: 4)
!221 = distinct !DILexicalBlock(scope: !222, file: !3, line: 62, column: 8)
!222 = distinct !DILexicalBlock(scope: !71, file: !3, line: 55, column: 2)
!223 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 304, elements: !224)
!224 = !{!225}
!225 = !DISubrange(count: 38)
!226 = !DILocalVariable(name: "____fmt", scope: !227, file: !3, line: 72, type: !230)
!227 = distinct !DILexicalBlock(scope: !228, file: !3, line: 72, column: 5)
!228 = distinct !DILexicalBlock(scope: !229, file: !3, line: 71, column: 4)
!229 = distinct !DILexicalBlock(scope: !222, file: !3, line: 70, column: 8)
!230 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 288, elements: !231)
!231 = !{!232}
!232 = !DISubrange(count: 36)
!233 = !DILocalVariable(name: "____fmt", scope: !234, file: !235, line: 91, type: !243)
!234 = distinct !DILexicalBlock(scope: !236, file: !235, line: 91, column: 3)
!235 = !DIFile(filename: "./common/check_rules.h", directory: "/home/server/git/anti-dos/main")
!236 = distinct !DILexicalBlock(scope: !237, file: !235, line: 90, column: 2)
!237 = distinct !DILexicalBlock(scope: !238, file: !235, line: 89, column: 5)
!238 = distinct !DISubprogram(name: "tcp_stupid", scope: !235, file: !235, line: 87, type: !239, isLocal: true, isDefinition: true, scopeLine: 88, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !241)
!239 = !DISubroutineType(types: !240)
!240 = !{!58, !181}
!241 = !{!242, !233}
!242 = !DILocalVariable(name: "pkt", arg: 1, scope: !238, file: !235, line: 87, type: !181)
!243 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 352, elements: !244)
!244 = !{!245}
!245 = !DISubrange(count: 44)
!246 = !DILocation(line: 91, column: 3, scope: !234, inlinedAt: !247)
!247 = distinct !DILocation(line: 87, column: 8, scope: !248)
!248 = distinct !DILexicalBlock(scope: !249, file: !3, line: 87, column: 8)
!249 = distinct !DILexicalBlock(scope: !222, file: !3, line: 83, column: 20)
!250 = !DILocalVariable(name: "____fmt", scope: !251, file: !235, line: 65, type: !264)
!251 = distinct !DILexicalBlock(scope: !252, file: !235, line: 65, column: 3)
!252 = distinct !DILexicalBlock(scope: !253, file: !235, line: 64, column: 2)
!253 = distinct !DILexicalBlock(scope: !254, file: !235, line: 63, column: 5)
!254 = distinct !DISubprogram(name: "icmp_stupid", scope: !235, file: !235, line: 61, type: !239, isLocal: true, isDefinition: true, scopeLine: 62, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !255)
!255 = !{!256, !250, !257}
!256 = !DILocalVariable(name: "pkt", arg: 1, scope: !254, file: !235, line: 61, type: !181)
!257 = !DILocalVariable(name: "____fmt", scope: !258, file: !235, line: 71, type: !261)
!258 = distinct !DILexicalBlock(scope: !259, file: !235, line: 71, column: 3)
!259 = distinct !DILexicalBlock(scope: !260, file: !235, line: 70, column: 2)
!260 = distinct !DILexicalBlock(scope: !254, file: !235, line: 69, column: 5)
!261 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 320, elements: !262)
!262 = !{!263}
!263 = !DISubrange(count: 40)
!264 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 360, elements: !265)
!265 = !{!266}
!266 = !DISubrange(count: 45)
!267 = !DILocation(line: 65, column: 3, scope: !251, inlinedAt: !268)
!268 = distinct !DILocation(line: 109, column: 8, scope: !269)
!269 = distinct !DILexicalBlock(scope: !249, file: !3, line: 109, column: 8)
!270 = !DILocation(line: 71, column: 3, scope: !258, inlinedAt: !268)
!271 = !DILocation(line: 28, column: 37, scope: !71)
!272 = !DILocation(line: 30, column: 38, scope: !71)
!273 = !{!274, !275, i64 4}
!274 = !{!"xdp_md", !275, i64 0, !275, i64 4, !275, i64 8, !275, i64 12, !275, i64 16}
!275 = !{!"int", !276, i64 0}
!276 = !{!"omnipotent char", !277, i64 0}
!277 = !{!"Simple C/C++ TBAA"}
!278 = !DILocation(line: 30, column: 27, scope: !71)
!279 = !DILocation(line: 30, column: 19, scope: !71)
!280 = !DILocation(line: 30, column: 8, scope: !71)
!281 = !DILocation(line: 31, column: 34, scope: !71)
!282 = !{!274, !275, i64 0}
!283 = !DILocation(line: 31, column: 23, scope: !71)
!284 = !DILocation(line: 31, column: 15, scope: !71)
!285 = !DILocation(line: 31, column: 8, scope: !71)
!286 = !DILocation(line: 33, column: 8, scope: !71)
!287 = !DILocation(line: 48, column: 8, scope: !71)
!288 = !DILocation(line: 35, column: 20, scope: !71)
!289 = !DILocation(line: 38, column: 17, scope: !71)
!290 = !DILocalVariable(name: "nh", arg: 1, scope: !291, file: !89, line: 17, type: !294)
!291 = distinct !DISubprogram(name: "parse_ethhdr", scope: !89, file: !89, line: 17, type: !292, isLocal: true, isDefinition: true, scopeLine: 20, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !296)
!292 = !DISubroutineType(types: !293)
!293 = !{!58, !294, !14, !295}
!294 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!295 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!296 = !{!290, !297, !298, !299, !300}
!297 = !DILocalVariable(name: "data_end", arg: 2, scope: !291, file: !89, line: 18, type: !14)
!298 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !291, file: !89, line: 19, type: !295)
!299 = !DILocalVariable(name: "eth", scope: !291, file: !89, line: 21, type: !93)
!300 = !DILocalVariable(name: "hdrsize", scope: !291, file: !89, line: 22, type: !58)
!301 = !DILocation(line: 17, column: 60, scope: !291, inlinedAt: !302)
!302 = distinct !DILocation(line: 51, column: 13, scope: !71)
!303 = !DILocation(line: 18, column: 12, scope: !291, inlinedAt: !302)
!304 = !DILocation(line: 19, column: 22, scope: !291, inlinedAt: !302)
!305 = !DILocation(line: 21, column: 17, scope: !291, inlinedAt: !302)
!306 = !DILocation(line: 22, column: 6, scope: !291, inlinedAt: !302)
!307 = !DILocation(line: 25, column: 10, scope: !308, inlinedAt: !302)
!308 = distinct !DILexicalBlock(scope: !291, file: !89, line: 25, column: 6)
!309 = !DILocation(line: 25, column: 14, scope: !308, inlinedAt: !302)
!310 = !DILocation(line: 25, column: 6, scope: !291, inlinedAt: !302)
!311 = !DILocation(line: 31, column: 14, scope: !291, inlinedAt: !302)
!312 = !{!313, !314, i64 12}
!313 = !{!"ethhdr", !276, i64 0, !276, i64 6, !314, i64 12}
!314 = !{!"short", !276, i64 0}
!315 = !DILocation(line: 54, column: 2, scope: !71)
!316 = !DILocalVariable(name: "nh", arg: 1, scope: !317, file: !89, line: 34, type: !294)
!317 = distinct !DISubprogram(name: "parse_iphdr", scope: !89, file: !89, line: 34, type: !318, isLocal: true, isDefinition: true, scopeLine: 37, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !321)
!318 = !DISubroutineType(types: !319)
!319 = !{!58, !294, !14, !320}
!320 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !107, size: 64)
!321 = !{!316, !322, !323, !324, !325}
!322 = !DILocalVariable(name: "data_end", arg: 2, scope: !317, file: !89, line: 35, type: !14)
!323 = !DILocalVariable(name: "iphdr", arg: 3, scope: !317, file: !89, line: 36, type: !320)
!324 = !DILocalVariable(name: "iph", scope: !317, file: !89, line: 38, type: !107)
!325 = !DILocalVariable(name: "hdrsize", scope: !317, file: !89, line: 39, type: !58)
!326 = !DILocation(line: 34, column: 59, scope: !317, inlinedAt: !327)
!327 = distinct !DILocation(line: 58, column: 14, scope: !222)
!328 = !DILocation(line: 35, column: 18, scope: !317, inlinedAt: !327)
!329 = !DILocation(line: 38, column: 16, scope: !317, inlinedAt: !327)
!330 = !DILocation(line: 40, column: 10, scope: !331, inlinedAt: !327)
!331 = distinct !DILexicalBlock(scope: !317, file: !89, line: 40, column: 6)
!332 = !DILocation(line: 40, column: 14, scope: !331, inlinedAt: !327)
!333 = !DILocation(line: 40, column: 6, scope: !317, inlinedAt: !327)
!334 = !DILocation(line: 43, column: 17, scope: !317, inlinedAt: !327)
!335 = !DILocation(line: 43, column: 21, scope: !317, inlinedAt: !327)
!336 = !DILocation(line: 45, column: 13, scope: !337, inlinedAt: !327)
!337 = distinct !DILexicalBlock(scope: !317, file: !89, line: 45, column: 5)
!338 = !DILocation(line: 45, column: 5, scope: !317, inlinedAt: !327)
!339 = !DILocation(line: 45, column: 5, scope: !337, inlinedAt: !327)
!340 = !DILocation(line: 49, column: 14, scope: !341, inlinedAt: !327)
!341 = distinct !DILexicalBlock(scope: !317, file: !89, line: 49, column: 6)
!342 = !DILocation(line: 49, column: 24, scope: !341, inlinedAt: !327)
!343 = !DILocation(line: 49, column: 6, scope: !317, inlinedAt: !327)
!344 = !DILocation(line: 55, column: 14, scope: !317, inlinedAt: !327)
!345 = !{!346, !276, i64 9}
!346 = !{!"iphdr", !276, i64 0, !276, i64 0, !276, i64 1, !314, i64 2, !314, i64 4, !314, i64 6, !276, i64 8, !276, i64 9, !314, i64 10, !275, i64 12, !275, i64 16}
!347 = !DILocation(line: 39, column: 16, scope: !71)
!348 = !DILocation(line: 62, column: 29, scope: !221)
!349 = !{!346, !275, i64 12}
!350 = !DILocation(line: 26, column: 48, scope: !351, inlinedAt: !356)
!351 = distinct !DISubprogram(name: "in_white_list", scope: !235, file: !235, line: 26, type: !352, isLocal: true, isDefinition: true, scopeLine: 27, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !354)
!352 = !DISubroutineType(types: !353)
!353 = !{!58, !61}
!354 = !{!355}
!355 = !DILocalVariable(name: "src_addr", arg: 1, scope: !351, file: !235, line: 26, type: !61)
!356 = distinct !DILocation(line: 62, column: 8, scope: !221)
!357 = !{!275, !275, i64 0}
!358 = !DILocation(line: 28, column: 6, scope: !359, inlinedAt: !356)
!359 = distinct !DILexicalBlock(scope: !351, file: !235, line: 28, column: 6)
!360 = !DILocation(line: 32, column: 1, scope: !351, inlinedAt: !356)
!361 = !DILocation(line: 62, column: 8, scope: !222)
!362 = !DILocation(line: 64, column: 5, scope: !219)
!363 = !DILocation(line: 64, column: 5, scope: !220)
!364 = !DILocation(line: 66, column: 5, scope: !220)
!365 = !DILocation(line: 70, column: 29, scope: !229)
!366 = !DILocation(line: 34, column: 48, scope: !367, inlinedAt: !370)
!367 = distinct !DISubprogram(name: "in_black_list", scope: !235, file: !235, line: 34, type: !352, isLocal: true, isDefinition: true, scopeLine: 35, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !368)
!368 = !{!369}
!369 = !DILocalVariable(name: "src_addr", arg: 1, scope: !367, file: !235, line: 34, type: !61)
!370 = distinct !DILocation(line: 70, column: 8, scope: !229)
!371 = !DILocation(line: 36, column: 6, scope: !372, inlinedAt: !370)
!372 = distinct !DILexicalBlock(scope: !367, file: !235, line: 36, column: 6)
!373 = !DILocation(line: 40, column: 1, scope: !367, inlinedAt: !370)
!374 = !DILocation(line: 70, column: 8, scope: !222)
!375 = !DILocation(line: 72, column: 5, scope: !227)
!376 = !DILocation(line: 72, column: 5, scope: !228)
!377 = !DILocation(line: 74, column: 5, scope: !228)
!378 = !DILocation(line: 78, column: 27, scope: !222)
!379 = !DILocation(line: 79, column: 28, scope: !222)
!380 = !{!346, !275, i64 16}
!381 = !DILocation(line: 80, column: 26, scope: !222)
!382 = !{!346, !314, i64 2}
!383 = !DILocation(line: 81, column: 26, scope: !222)
!384 = !{!346, !314, i64 6}
!385 = !DILocation(line: 83, column: 4, scope: !222)
!386 = !DILocalVariable(name: "nh", arg: 1, scope: !387, file: !89, line: 93, type: !294)
!387 = distinct !DISubprogram(name: "parse_tcphdr", scope: !89, file: !89, line: 93, type: !388, isLocal: true, isDefinition: true, scopeLine: 96, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !391)
!388 = !DISubroutineType(types: !389)
!389 = !{!58, !294, !14, !390}
!390 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !126, size: 64)
!391 = !{!386, !392, !393, !394, !395}
!392 = !DILocalVariable(name: "data_end", arg: 2, scope: !387, file: !89, line: 94, type: !14)
!393 = !DILocalVariable(name: "tcphdr", arg: 3, scope: !387, file: !89, line: 95, type: !390)
!394 = !DILocalVariable(name: "len", scope: !387, file: !89, line: 97, type: !58)
!395 = !DILocalVariable(name: "h", scope: !387, file: !89, line: 98, type: !126)
!396 = !DILocation(line: 93, column: 60, scope: !387, inlinedAt: !397)
!397 = distinct !DILocation(line: 85, column: 5, scope: !398)
!398 = distinct !DILexicalBlock(scope: !399, file: !3, line: 85, column: 5)
!399 = distinct !DILexicalBlock(scope: !249, file: !3, line: 85, column: 5)
!400 = !DILocation(line: 94, column: 12, scope: !387, inlinedAt: !397)
!401 = !DILocation(line: 98, column: 17, scope: !387, inlinedAt: !397)
!402 = !DILocation(line: 99, column: 8, scope: !403, inlinedAt: !397)
!403 = distinct !DILexicalBlock(scope: !387, file: !89, line: 99, column: 6)
!404 = !DILocation(line: 99, column: 12, scope: !403, inlinedAt: !397)
!405 = !DILocation(line: 99, column: 6, scope: !387, inlinedAt: !397)
!406 = !DILocation(line: 102, column: 11, scope: !387, inlinedAt: !397)
!407 = !DILocation(line: 102, column: 16, scope: !387, inlinedAt: !397)
!408 = !DILocation(line: 104, column: 9, scope: !409, inlinedAt: !397)
!409 = distinct !DILexicalBlock(scope: !387, file: !89, line: 104, column: 5)
!410 = !DILocation(line: 104, column: 5, scope: !387, inlinedAt: !397)
!411 = !DILocation(line: 104, column: 5, scope: !409, inlinedAt: !397)
!412 = !DILocation(line: 108, column: 14, scope: !413, inlinedAt: !397)
!413 = distinct !DILexicalBlock(scope: !387, file: !89, line: 108, column: 6)
!414 = !DILocation(line: 108, column: 20, scope: !413, inlinedAt: !397)
!415 = !DILocation(line: 108, column: 6, scope: !387, inlinedAt: !397)
!416 = !DILocation(line: 40, column: 17, scope: !71)
!417 = !DILocation(line: 44, column: 20, scope: !71)
!418 = !DILocation(line: 87, column: 57, scope: !238, inlinedAt: !247)
!419 = !DILocalVariable(name: "frag_off", arg: 1, scope: !420, file: !235, line: 79, type: !16)
!420 = distinct !DISubprogram(name: "tcp_fragment", scope: !235, file: !235, line: 79, type: !421, isLocal: true, isDefinition: true, scopeLine: 80, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !423)
!421 = !DISubroutineType(types: !422)
!422 = !{!58, !16, !112}
!423 = !{!419, !424}
!424 = !DILocalVariable(name: "syn_flag", arg: 2, scope: !420, file: !235, line: 79, type: !112)
!425 = !DILocation(line: 79, column: 47, scope: !420, inlinedAt: !426)
!426 = distinct !DILocation(line: 89, column: 5, scope: !237, inlinedAt: !247)
!427 = !DILocation(line: 81, column: 15, scope: !428, inlinedAt: !426)
!428 = distinct !DILexicalBlock(scope: !420, file: !235, line: 81, column: 5)
!429 = !DILocation(line: 81, column: 61, scope: !428, inlinedAt: !426)
!430 = !DILocation(line: 89, column: 5, scope: !237, inlinedAt: !247)
!431 = !DILocation(line: 89, column: 5, scope: !238, inlinedAt: !247)
!432 = !DILocation(line: 91, column: 3, scope: !236, inlinedAt: !247)
!433 = !DILocation(line: 87, column: 8, scope: !249)
!434 = !DILocation(line: 94, column: 34, scope: !249)
!435 = !{!436, !314, i64 0}
!436 = !{!"tcphdr", !314, i64 0, !314, i64 2, !275, i64 4, !275, i64 8, !314, i64 12, !314, i64 12, !314, i64 13, !314, i64 13, !314, i64 13, !314, i64 13, !314, i64 13, !314, i64 13, !314, i64 13, !314, i64 13, !314, i64 14, !314, i64 16, !314, i64 18}
!437 = !DILocation(line: 95, column: 34, scope: !249)
!438 = !{!436, !314, i64 2}
!439 = !DILocation(line: 96, column: 28, scope: !249)
!440 = !{!436, !275, i64 4}
!441 = !DILocation(line: 97, column: 5, scope: !249)
!442 = !DILocalVariable(name: "nh", arg: 1, scope: !443, file: !89, line: 73, type: !294)
!443 = distinct !DISubprogram(name: "parse_udphdr", scope: !89, file: !89, line: 73, type: !444, isLocal: true, isDefinition: true, scopeLine: 76, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !447)
!444 = !DISubroutineType(types: !445)
!445 = !{!58, !294, !14, !446}
!446 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !148, size: 64)
!447 = !{!442, !448, !449, !450, !451}
!448 = !DILocalVariable(name: "data_end", arg: 2, scope: !443, file: !89, line: 74, type: !14)
!449 = !DILocalVariable(name: "udphdr", arg: 3, scope: !443, file: !89, line: 75, type: !446)
!450 = !DILocalVariable(name: "len", scope: !443, file: !89, line: 77, type: !58)
!451 = !DILocalVariable(name: "h", scope: !443, file: !89, line: 78, type: !148)
!452 = !DILocation(line: 73, column: 60, scope: !443, inlinedAt: !453)
!453 = distinct !DILocation(line: 100, column: 5, scope: !454)
!454 = distinct !DILexicalBlock(scope: !455, file: !3, line: 100, column: 5)
!455 = distinct !DILexicalBlock(scope: !249, file: !3, line: 100, column: 5)
!456 = !DILocation(line: 74, column: 12, scope: !443, inlinedAt: !453)
!457 = !DILocation(line: 78, column: 17, scope: !443, inlinedAt: !453)
!458 = !DILocation(line: 80, column: 8, scope: !459, inlinedAt: !453)
!459 = distinct !DILexicalBlock(scope: !443, file: !89, line: 80, column: 6)
!460 = !DILocation(line: 80, column: 14, scope: !459, inlinedAt: !453)
!461 = !DILocation(line: 80, column: 12, scope: !459, inlinedAt: !453)
!462 = !DILocation(line: 80, column: 6, scope: !443, inlinedAt: !453)
!463 = !DILocation(line: 86, column: 8, scope: !443, inlinedAt: !453)
!464 = !{!465, !314, i64 4}
!465 = !{!"udphdr", !314, i64 0, !314, i64 2, !314, i64 4, !314, i64 6}
!466 = !DILocation(line: 87, column: 10, scope: !467, inlinedAt: !453)
!467 = distinct !DILexicalBlock(scope: !443, file: !89, line: 87, column: 6)
!468 = !DILocation(line: 87, column: 6, scope: !443, inlinedAt: !453)
!469 = !DILocation(line: 41, column: 17, scope: !71)
!470 = !DILocation(line: 103, column: 34, scope: !249)
!471 = !{!465, !314, i64 0}
!472 = !DILocation(line: 104, column: 34, scope: !249)
!473 = !{!465, !314, i64 2}
!474 = !DILocation(line: 105, column: 5, scope: !249)
!475 = !DILocation(line: 61, column: 58, scope: !254, inlinedAt: !268)
!476 = !DILocalVariable(name: "frag_off", arg: 1, scope: !477, file: !235, line: 45, type: !16)
!477 = distinct !DISubprogram(name: "icmp_fragment", scope: !235, file: !235, line: 45, type: !478, isLocal: true, isDefinition: true, scopeLine: 46, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !480)
!478 = !DISubroutineType(types: !479)
!479 = !{!58, !16}
!480 = !{!476}
!481 = !DILocation(line: 45, column: 48, scope: !477, inlinedAt: !482)
!482 = distinct !DILocation(line: 63, column: 5, scope: !253, inlinedAt: !268)
!483 = !DILocation(line: 47, column: 14, scope: !484, inlinedAt: !482)
!484 = distinct !DILexicalBlock(scope: !477, file: !235, line: 47, column: 5)
!485 = !DILocation(line: 63, column: 5, scope: !254, inlinedAt: !268)
!486 = !DILocation(line: 65, column: 3, scope: !252, inlinedAt: !268)
!487 = !DILocation(line: 66, column: 3, scope: !252, inlinedAt: !268)
!488 = !DILocalVariable(name: "tot_len", arg: 1, scope: !489, file: !235, line: 53, type: !16)
!489 = distinct !DISubprogram(name: "icmp_large_packet", scope: !235, file: !235, line: 53, type: !478, isLocal: true, isDefinition: true, scopeLine: 54, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !490)
!490 = !{!488}
!491 = !DILocation(line: 53, column: 52, scope: !489, inlinedAt: !492)
!492 = distinct !DILocation(line: 69, column: 5, scope: !260, inlinedAt: !268)
!493 = !DILocation(line: 55, column: 5, scope: !494, inlinedAt: !492)
!494 = distinct !DILexicalBlock(scope: !489, file: !235, line: 55, column: 5)
!495 = !DILocation(line: 55, column: 24, scope: !494, inlinedAt: !492)
!496 = !DILocation(line: 69, column: 5, scope: !254, inlinedAt: !268)
!497 = !DILocation(line: 71, column: 3, scope: !259, inlinedAt: !268)
!498 = !DILocation(line: 72, column: 3, scope: !259, inlinedAt: !268)
!499 = !DILocation(line: 138, column: 30, scope: !71)
!500 = !DILocation(line: 138, column: 21, scope: !71)
!501 = !DILocation(line: 139, column: 38, scope: !71)
!502 = !DILocation(line: 139, column: 22, scope: !71)
!503 = !DILocation(line: 143, column: 29, scope: !71)
!504 = !DILocation(line: 143, column: 22, scope: !71)
!505 = !DILocation(line: 143, column: 2, scope: !71)
!506 = !DILocation(line: 45, column: 18, scope: !71)
!507 = !DILocalVariable(name: "ctx", arg: 1, scope: !508, file: !24, line: 29, type: !74)
!508 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !24, file: !24, line: 29, type: !509, isLocal: true, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: true, unit: !2, variables: !511)
!509 = !DISubroutineType(types: !510)
!510 = !{!61, !74, !61, !196}
!511 = !{!507, !512, !513, !514}
!512 = !DILocalVariable(name: "action", arg: 2, scope: !508, file: !24, line: 29, type: !61)
!513 = !DILocalVariable(name: "pkt", arg: 3, scope: !508, file: !24, line: 29, type: !196)
!514 = !DILocalVariable(name: "rec", scope: !508, file: !24, line: 35, type: !515)
!515 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !516, size: 64)
!516 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !517, line: 5, size: 128, elements: !518)
!517 = !DIFile(filename: "./common/xdp_stats_kern_user.h", directory: "/home/server/git/anti-dos/main")
!518 = !{!519, !520}
!519 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !516, file: !517, line: 6, baseType: !19, size: 64)
!520 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !516, file: !517, line: 7, baseType: !19, size: 64, offset: 64)
!521 = !DILocation(line: 29, column: 46, scope: !508, inlinedAt: !522)
!522 = distinct !DILocation(line: 146, column: 9, scope: !71)
!523 = !DILocation(line: 29, column: 57, scope: !508, inlinedAt: !522)
!524 = !DILocation(line: 35, column: 24, scope: !508, inlinedAt: !522)
!525 = !DILocation(line: 35, column: 18, scope: !508, inlinedAt: !522)
!526 = !DILocation(line: 36, column: 7, scope: !527, inlinedAt: !522)
!527 = distinct !DILexicalBlock(scope: !508, file: !24, line: 36, column: 6)
!528 = !DILocation(line: 36, column: 6, scope: !508, inlinedAt: !522)
!529 = !DILocation(line: 39, column: 7, scope: !508, inlinedAt: !522)
!530 = !DILocation(line: 39, column: 17, scope: !508, inlinedAt: !522)
!531 = !{!532, !533, i64 0}
!532 = !{!"datarec", !533, i64 0, !533, i64 8}
!533 = !{!"long long", !276, i64 0}
!534 = !DILocation(line: 40, column: 25, scope: !508, inlinedAt: !522)
!535 = !DILocation(line: 40, column: 41, scope: !508, inlinedAt: !522)
!536 = !DILocation(line: 40, column: 34, scope: !508, inlinedAt: !522)
!537 = !DILocation(line: 40, column: 19, scope: !508, inlinedAt: !522)
!538 = !DILocation(line: 40, column: 7, scope: !508, inlinedAt: !522)
!539 = !DILocation(line: 40, column: 16, scope: !508, inlinedAt: !522)
!540 = !{!532, !533, i64 8}
!541 = !DILocation(line: 42, column: 6, scope: !542, inlinedAt: !522)
!542 = distinct !DILexicalBlock(scope: !508, file: !24, line: 42, column: 6)
!543 = !DILocation(line: 42, column: 13, scope: !542, inlinedAt: !522)
!544 = !DILocation(line: 42, column: 6, scope: !508, inlinedAt: !522)
!545 = !DILocation(line: 45, column: 24, scope: !508, inlinedAt: !522)
!546 = !DILocation(line: 46, column: 6, scope: !508, inlinedAt: !522)
!547 = !DILocation(line: 46, column: 25, scope: !508, inlinedAt: !522)
!548 = !DILocation(line: 46, column: 31, scope: !508, inlinedAt: !522)
!549 = !DILocation(line: 45, column: 2, scope: !508, inlinedAt: !522)
!550 = !DILocation(line: 50, column: 9, scope: !508, inlinedAt: !522)
!551 = !DILocation(line: 51, column: 1, scope: !508, inlinedAt: !522)
!552 = !DILocation(line: 146, column: 2, scope: !71)
