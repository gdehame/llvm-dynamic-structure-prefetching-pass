; ModuleID = 'makegraph.c'
source_filename = "makegraph.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.vert_st = type { i32, ptr, ptr }

@HashRange = internal unnamed_addr global i32 0, align 4, !dbg !0
@str = private unnamed_addr constant [13 x i8] c"Make phase 2\00", align 1
@str.4 = private unnamed_addr constant [13 x i8] c"Make phase 3\00", align 1
@str.5 = private unnamed_addr constant [13 x i8] c"Make phase 4\00", align 1
@str.6 = private unnamed_addr constant [15 x i8] c"Make returning\00", align 1

; Function Attrs: nounwind uwtable
define dso_local noalias ptr @MakeGraph(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 !dbg !66 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !70, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata i32 %1, metadata !71, metadata !DIExpression()), !dbg !80
  %3 = sdiv i32 %0, %1, !dbg !81
  call void @llvm.dbg.value(metadata i32 %3, metadata !72, metadata !DIExpression()), !dbg !80
  %4 = tail call noalias dereferenceable_or_null(8) ptr @malloc(i64 noundef 8) #7, !dbg !82
  call void @llvm.dbg.value(metadata ptr %4, metadata !79, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata i32 0, metadata !73, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata i32 poison, metadata !73, metadata !DIExpression()), !dbg !80
  store ptr null, ptr %4, align 8, !dbg !83, !tbaa !87
  call void @llvm.dbg.value(metadata i32 1, metadata !73, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata i32 poison, metadata !73, metadata !DIExpression()), !dbg !80
  %5 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !91
  %6 = add i32 %1, -1, !dbg !92
  call void @llvm.dbg.value(metadata i32 %6, metadata !74, metadata !DIExpression()), !dbg !80
  %7 = icmp sgt i32 %1, 0, !dbg !94
  br i1 %7, label %10, label %8, !dbg !96

8:                                                ; preds = %2
  %9 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.4), !dbg !97
  call void @llvm.dbg.value(metadata i32 %6, metadata !74, metadata !DIExpression()), !dbg !80
  br label %102, !dbg !98

10:                                               ; preds = %2
  %11 = sext i32 %3 to i64
  %12 = mul nsw i64 %11, 24
  %13 = icmp sgt i32 %3, 0
  %14 = sdiv i32 %0, 4
  br i1 %13, label %19, label %15, !dbg !100

15:                                               ; preds = %10
  %16 = zext i32 %1 to i64, !dbg !96
  %17 = shl nuw nsw i64 %16, 3, !dbg !96
  tail call void @llvm.memset.p0.i64(ptr nonnull align 8 %4, i8 0, i64 %17, i1 false), !dbg !103, !tbaa !87
  call void @llvm.dbg.value(metadata i64 poison, metadata !74, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata ptr poison, metadata !78, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata ptr poison, metadata !76, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata i32 poison, metadata !73, metadata !DIExpression()), !dbg !80
  %18 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.4), !dbg !97
  call void @llvm.dbg.value(metadata i32 %6, metadata !74, metadata !DIExpression()), !dbg !80
  br label %44, !dbg !98

19:                                               ; preds = %10
  %20 = zext i32 %6 to i64, !dbg !96
  %21 = zext i32 %3 to i64
  br label %22, !dbg !96

22:                                               ; preds = %19, %38
  %23 = phi i64 [ %20, %19 ], [ %40, %38 ]
  call void @llvm.dbg.value(metadata i64 %23, metadata !74, metadata !DIExpression()), !dbg !80
  %24 = tail call noalias ptr @malloc(i64 noundef %12) #7, !dbg !104
  call void @llvm.dbg.value(metadata ptr %24, metadata !78, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata ptr null, metadata !76, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata i32 0, metadata !73, metadata !DIExpression()), !dbg !80
  br label %25, !dbg !100

25:                                               ; preds = %22, %25
  %26 = phi i64 [ 0, %22 ], [ %36, %25 ]
  %27 = phi ptr [ null, %22 ], [ %32, %25 ]
  call void @llvm.dbg.value(metadata i64 %26, metadata !73, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata ptr %27, metadata !76, metadata !DIExpression()), !dbg !80
  %28 = trunc i64 %26 to i32, !dbg !105
  %29 = xor i32 %28, -1, !dbg !105
  %30 = add i32 %3, %29, !dbg !105
  %31 = sext i32 %30 to i64, !dbg !108
  %32 = getelementptr inbounds %struct.vert_st, ptr %24, i64 %31, !dbg !108
  call void @llvm.dbg.value(metadata ptr %32, metadata !77, metadata !DIExpression()), !dbg !80
  store i32 %14, ptr @HashRange, align 4, !dbg !109, !tbaa !110
  store i32 9999999, ptr %32, align 8, !dbg !112, !tbaa !113
  %33 = tail call ptr @MakeHash(i32 noundef %14, ptr noundef nonnull @hashfunc) #8, !dbg !115
  %34 = getelementptr inbounds %struct.vert_st, ptr %24, i64 %31, i32 2, !dbg !116
  store ptr %33, ptr %34, align 8, !dbg !117, !tbaa !118
  %35 = getelementptr inbounds %struct.vert_st, ptr %24, i64 %31, i32 1, !dbg !119
  store ptr %27, ptr %35, align 8, !dbg !120, !tbaa !121
  call void @llvm.dbg.value(metadata ptr %32, metadata !76, metadata !DIExpression()), !dbg !80
  %36 = add nuw nsw i64 %26, 1, !dbg !122
  call void @llvm.dbg.value(metadata i64 %36, metadata !73, metadata !DIExpression()), !dbg !80
  %37 = icmp eq i64 %36, %21, !dbg !123
  br i1 %37, label %38, label %25, !dbg !100, !llvm.loop !124

38:                                               ; preds = %25
  %39 = getelementptr inbounds [1 x ptr], ptr %4, i64 0, i64 %23, !dbg !127
  store ptr %24, ptr %39, align 8, !dbg !103, !tbaa !87
  %40 = add nsw i64 %23, -1, !dbg !128
  call void @llvm.dbg.value(metadata i64 %40, metadata !74, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !80
  %41 = icmp sgt i64 %23, 0, !dbg !94
  br i1 %41, label %22, label %42, !dbg !96, !llvm.loop !129

42:                                               ; preds = %38
  %43 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.4), !dbg !97
  call void @llvm.dbg.value(metadata i32 %6, metadata !74, metadata !DIExpression()), !dbg !80
  br i1 %7, label %44, label %102, !dbg !98

44:                                               ; preds = %15, %42
  %45 = mul i32 %3, %1
  %46 = icmp sgt i32 %45, 0
  br i1 %46, label %47, label %102, !dbg !131

47:                                               ; preds = %44
  %48 = zext i32 %6 to i64
  %49 = getelementptr inbounds [1 x ptr], ptr %4, i64 0, i64 %48
  %50 = load ptr, ptr %49, align 8, !tbaa !87
  br label %51, !dbg !98

51:                                               ; preds = %47, %99
  %52 = phi i64 [ %48, %47 ], [ %100, %99 ]
  call void @llvm.dbg.value(metadata i64 %52, metadata !74, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata !DIArgList(i32 %3, i64 %52), metadata !75, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_mul, DW_OP_stack_value)), !dbg !80
  call void @llvm.dbg.value(metadata !DIArgList(i32 %3, i64 %52), metadata !140, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_mul, DW_OP_stack_value)), !dbg !159
  call void @llvm.dbg.value(metadata ptr %4, metadata !141, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 %1, metadata !142, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 %3, metadata !143, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 %0, metadata !144, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i64 %52, metadata !145, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 poison, metadata !148, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata ptr poison, metadata !147, metadata !DIExpression()), !dbg !159
  %53 = getelementptr inbounds [1 x ptr], ptr %4, i64 0, i64 %52, !dbg !160
  call void @llvm.dbg.value(metadata ptr poison, metadata !146, metadata !DIExpression()), !dbg !159
  %54 = load ptr, ptr %53, align 8, !dbg !161, !tbaa !87
  call void @llvm.dbg.value(metadata ptr %54, metadata !146, metadata !DIExpression()), !dbg !159
  %55 = icmp eq ptr %54, null, !dbg !162
  br i1 %55, label %99, label %56, !dbg !162

56:                                               ; preds = %51
  %57 = trunc i64 %52 to i32, !dbg !163
  call void @llvm.dbg.value(metadata !DIArgList(i32 %3, i32 %57), metadata !75, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_mul, DW_OP_stack_value)), !dbg !80
  call void @llvm.dbg.value(metadata !DIArgList(i32 %3, i32 %57), metadata !140, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_mul, DW_OP_stack_value)), !dbg !159
  %58 = mul nsw i32 %3, %57, !dbg !163
  call void @llvm.dbg.value(metadata i32 %58, metadata !75, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.value(metadata i32 %58, metadata !140, metadata !DIExpression()), !dbg !159
  br label %59, !dbg !162

59:                                               ; preds = %56, %94
  %60 = phi ptr [ %97, %94 ], [ %54, %56 ]
  %61 = phi i32 [ %95, %94 ], [ %58, %56 ]
  call void @llvm.dbg.value(metadata i32 %61, metadata !140, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 0, metadata !148, metadata !DIExpression()), !dbg !159
  %62 = getelementptr inbounds %struct.vert_st, ptr %60, i64 0, i32 2
  br label %63, !dbg !131

63:                                               ; preds = %91, %59
  %64 = phi i32 [ 0, %59 ], [ %92, %91 ]
  call void @llvm.dbg.value(metadata i32 %64, metadata !148, metadata !DIExpression()), !dbg !159
  %65 = icmp eq i32 %64, %61, !dbg !164
  br i1 %65, label %91, label %66, !dbg !166

66:                                               ; preds = %63
  call void @llvm.dbg.value(metadata i32 %64, metadata !167, metadata !DIExpression()), !dbg !176
  call void @llvm.dbg.value(metadata i32 %61, metadata !172, metadata !DIExpression()), !dbg !176
  call void @llvm.dbg.value(metadata i32 %0, metadata !173, metadata !DIExpression()), !dbg !176
  %67 = tail call i32 @llvm.smin.i32(i32 %64, i32 %61)
  %68 = tail call i32 @llvm.smax.i32(i32 %64, i32 %61)
  call void @llvm.dbg.value(metadata i32 %68, metadata !175, metadata !DIExpression()), !dbg !176
  call void @llvm.dbg.value(metadata i32 %67, metadata !174, metadata !DIExpression()), !dbg !176
  %69 = mul nsw i32 %67, %0, !dbg !179
  %70 = add nsw i32 %69, %68, !dbg !180
  call void @llvm.dbg.value(metadata i32 %70, metadata !181, metadata !DIExpression()), !dbg !187
  call void @llvm.dbg.value(metadata i32 %70, metadata !189, metadata !DIExpression()), !dbg !199
  call void @llvm.dbg.value(metadata i32 31415821, metadata !194, metadata !DIExpression()), !dbg !199
  %71 = sdiv i32 %70, 10000, !dbg !201
  call void @llvm.dbg.value(metadata i32 %71, metadata !195, metadata !DIExpression()), !dbg !199
  %72 = srem i32 %70, 10000, !dbg !202
  call void @llvm.dbg.value(metadata i32 %72, metadata !196, metadata !DIExpression()), !dbg !199
  call void @llvm.dbg.value(metadata i32 3141, metadata !197, metadata !DIExpression()), !dbg !199
  call void @llvm.dbg.value(metadata i32 5821, metadata !198, metadata !DIExpression()), !dbg !199
  %73 = mul nsw i32 %72, 3141, !dbg !203
  %74 = mul nsw i32 %71, 5821, !dbg !204
  %75 = add nsw i32 %73, %74, !dbg !205
  %76 = srem i32 %75, 10000, !dbg !206
  %77 = mul nsw i32 %76, 10000, !dbg !207
  %78 = mul nsw i32 %72, 5821, !dbg !208
  %79 = add nsw i32 %78, 1, !dbg !209
  %80 = add nsw i32 %79, %77, !dbg !210
  call void @llvm.dbg.value(metadata i32 %80, metadata !186, metadata !DIExpression()), !dbg !187
  %81 = srem i32 %80, 2048, !dbg !211
  %82 = add nsw i32 %81, 1, !dbg !212
  call void @llvm.dbg.value(metadata i32 %82, metadata !153, metadata !DIExpression()), !dbg !213
  call void @llvm.dbg.value(metadata !DIArgList(i32 %64, i32 %3), metadata !149, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_div, DW_OP_stack_value)), !dbg !213
  %83 = srem i32 %64, %3, !dbg !214
  call void @llvm.dbg.value(metadata i32 %83, metadata !152, metadata !DIExpression()), !dbg !213
  %84 = zext i32 %83 to i64, !dbg !215
  %85 = getelementptr inbounds %struct.vert_st, ptr %50, i64 %84, !dbg !215
  call void @llvm.dbg.value(metadata ptr %85, metadata !154, metadata !DIExpression()), !dbg !213
  %86 = load ptr, ptr %62, align 8, !dbg !216, !tbaa !118
  call void @llvm.dbg.value(metadata ptr %86, metadata !155, metadata !DIExpression()), !dbg !213
  %87 = sext i32 %82 to i64, !dbg !217
  %88 = inttoptr i64 %87 to ptr, !dbg !217
  %89 = ptrtoint ptr %85 to i64, !dbg !218
  %90 = trunc i64 %89 to i32, !dbg !218
  tail call void @HashInsert(ptr noundef %88, i32 noundef %90, ptr noundef %86) #8, !dbg !219
  br label %91, !dbg !220

91:                                               ; preds = %66, %63
  %92 = add nuw nsw i32 %64, 1, !dbg !221
  call void @llvm.dbg.value(metadata i32 %92, metadata !148, metadata !DIExpression()), !dbg !159
  %93 = icmp eq i32 %92, %45, !dbg !222
  br i1 %93, label %94, label %63, !dbg !131, !llvm.loop !223

94:                                               ; preds = %91
  %95 = add nsw i32 %61, 1, !dbg !225
  call void @llvm.dbg.value(metadata i32 %95, metadata !140, metadata !DIExpression()), !dbg !159
  %96 = getelementptr inbounds %struct.vert_st, ptr %60, i64 0, i32 1, !dbg !226
  call void @llvm.dbg.value(metadata ptr poison, metadata !146, metadata !DIExpression()), !dbg !159
  %97 = load ptr, ptr %96, align 8, !dbg !161, !tbaa !87
  call void @llvm.dbg.value(metadata ptr %97, metadata !146, metadata !DIExpression()), !dbg !159
  %98 = icmp eq ptr %97, null, !dbg !162
  br i1 %98, label %99, label %59, !dbg !162, !llvm.loop !227

99:                                               ; preds = %94, %51
  %100 = add nsw i64 %52, -1, !dbg !229
  call void @llvm.dbg.value(metadata i64 %100, metadata !74, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !80
  %101 = icmp sgt i64 %52, 0, !dbg !230
  br i1 %101, label %51, label %102, !dbg !98, !llvm.loop !231

102:                                              ; preds = %99, %44, %8, %42
  %103 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.5), !dbg !233
  %104 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.6), !dbg !234
  ret ptr %4, !dbg !235
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !236 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #1

declare !dbg !244 ptr @MakeHash(i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(read, argmem: none, inaccessiblemem: none) uwtable
define internal i32 @hashfunc(i32 noundef %0) #3 !dbg !247 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !249, metadata !DIExpression()), !dbg !250
  %2 = lshr i32 %0, 3, !dbg !251
  %3 = load i32, ptr @HashRange, align 4, !dbg !252, !tbaa !110
  %4 = urem i32 %2, %3, !dbg !253
  ret i32 %4, !dbg !254
}

declare !dbg !255 void @HashInsert(ptr noundef, i32 noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #4

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #6

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(read, argmem: none, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #7 = { nounwind allocsize(0) }
attributes #8 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!59, !60, !61, !62, !63, !64}
!llvm.ident = !{!65}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "HashRange", scope: !2, file: !3, line: 11, type: !17, isLocal: true, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "clang version 16.0.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !43, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "makegraph.c", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "ea1b44e8619250a68bf4426e9912e2f6")
!4 = !{!5, !12, !34, !32}
!5 = !DIDerivedType(tag: DW_TAG_typedef, name: "Graph", file: !6, line: 18, baseType: !7)
!6 = !DIFile(filename: "./mst.h", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "48f1a7db8e821566d507ccb3a3465101")
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "graph_st", file: !6, line: 16, size: 64, elements: !9)
!9 = !{!10}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "vlist", scope: !8, file: !6, line: 17, baseType: !11, size: 64)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 64, elements: !41)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "Vertex", file: !6, line: 14, baseType: !13)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vert_st", file: !6, line: 10, size: 192, elements: !15)
!15 = !{!16, !18, !19}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "mindist", scope: !14, file: !6, line: 11, baseType: !17, size: 32)
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !14, file: !6, line: 12, baseType: !13, size: 64, offset: 64)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "edgehash", scope: !14, file: !6, line: 13, baseType: !20, size: 64, offset: 128)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "Hash", file: !21, line: 15, baseType: !22)
!21 = !DIFile(filename: "./hash.h", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "737edc72d4dc38a7950efc2ecfae2b7e")
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash", file: !21, line: 11, size: 192, elements: !24)
!24 = !{!25, !36, !40}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "array", scope: !23, file: !21, line: 12, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "HashEntry", file: !21, line: 9, baseType: !28)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash_entry", file: !21, line: 5, size: 192, elements: !30)
!30 = !{!31, !33, !35}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !29, file: !21, line: 6, baseType: !32, size: 32)
!32 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "entry", scope: !29, file: !21, line: 7, baseType: !34, size: 64, offset: 64)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !29, file: !21, line: 8, baseType: !28, size: 64, offset: 128)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "mapfunc", scope: !23, file: !21, line: 13, baseType: !37, size: 64, offset: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DISubroutineType(types: !39)
!39 = !{!17, !32}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !23, file: !21, line: 14, baseType: !17, size: 32, offset: 128)
!41 = !{!42}
!42 = !DISubrange(count: 1)
!43 = !{!44, !50, !52, !54, !0}
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression())
!45 = distinct !DIGlobalVariable(scope: null, file: !3, line: 88, type: !46, isLocal: true, isDefinition: true)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 112, elements: !48)
!47 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!48 = !{!49}
!49 = !DISubrange(count: 14)
!50 = !DIGlobalVariableExpression(var: !51, expr: !DIExpression())
!51 = distinct !DIGlobalVariable(scope: null, file: !3, line: 105, type: !46, isLocal: true, isDefinition: true)
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(scope: null, file: !3, line: 111, type: !46, isLocal: true, isDefinition: true)
!54 = !DIGlobalVariableExpression(var: !55, expr: !DIExpression())
!55 = distinct !DIGlobalVariable(scope: null, file: !3, line: 113, type: !56, isLocal: true, isDefinition: true)
!56 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 128, elements: !57)
!57 = !{!58}
!58 = !DISubrange(count: 16)
!59 = !{i32 7, !"Dwarf Version", i32 5}
!60 = !{i32 2, !"Debug Info Version", i32 3}
!61 = !{i32 1, !"wchar_size", i32 4}
!62 = !{i32 8, !"PIC Level", i32 2}
!63 = !{i32 7, !"PIE Level", i32 2}
!64 = !{i32 7, !"uwtable", i32 2}
!65 = !{!"clang version 16.0.0"}
!66 = distinct !DISubprogram(name: "MakeGraph", scope: !3, file: !3, line: 75, type: !67, scopeLine: 76, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !69)
!67 = !DISubroutineType(types: !68)
!68 = !{!5, !17, !17}
!69 = !{!70, !71, !72, !73, !74, !75, !76, !77, !78, !79}
!70 = !DILocalVariable(name: "numvert", arg: 1, scope: !66, file: !3, line: 75, type: !17)
!71 = !DILocalVariable(name: "numproc", arg: 2, scope: !66, file: !3, line: 75, type: !17)
!72 = !DILocalVariable(name: "perproc", scope: !66, file: !3, line: 77, type: !17)
!73 = !DILocalVariable(name: "i", scope: !66, file: !3, line: 78, type: !17)
!74 = !DILocalVariable(name: "j", scope: !66, file: !3, line: 78, type: !17)
!75 = !DILocalVariable(name: "count1", scope: !66, file: !3, line: 79, type: !17)
!76 = !DILocalVariable(name: "v", scope: !66, file: !3, line: 80, type: !12)
!77 = !DILocalVariable(name: "tmp", scope: !66, file: !3, line: 80, type: !12)
!78 = !DILocalVariable(name: "block", scope: !66, file: !3, line: 81, type: !12)
!79 = !DILocalVariable(name: "retval", scope: !66, file: !3, line: 82, type: !5)
!80 = !DILocation(line: 0, scope: !66)
!81 = !DILocation(line: 77, column: 24, scope: !66)
!82 = !DILocation(line: 83, column: 19, scope: !66)
!83 = !DILocation(line: 86, column: 23, scope: !84)
!84 = distinct !DILexicalBlock(scope: !85, file: !3, line: 85, column: 5)
!85 = distinct !DILexicalBlock(scope: !86, file: !3, line: 84, column: 3)
!86 = distinct !DILexicalBlock(scope: !66, file: !3, line: 84, column: 3)
!87 = !{!88, !88, i64 0}
!88 = !{!"any pointer", !89, i64 0}
!89 = !{!"omnipotent char", !90, i64 0}
!90 = !{!"Simple C/C++ TBAA"}
!91 = !DILocation(line: 88, column: 3, scope: !66)
!92 = !DILocation(line: 89, column: 17, scope: !93)
!93 = distinct !DILexicalBlock(scope: !66, file: !3, line: 89, column: 3)
!94 = !DILocation(line: 89, column: 22, scope: !95)
!95 = distinct !DILexicalBlock(scope: !93, file: !3, line: 89, column: 3)
!96 = !DILocation(line: 89, column: 3, scope: !93)
!97 = !DILocation(line: 105, column: 3, scope: !66)
!98 = !DILocation(line: 106, column: 3, scope: !99)
!99 = distinct !DILexicalBlock(scope: !66, file: !3, line: 106, column: 3)
!100 = !DILocation(line: 93, column: 7, scope: !101)
!101 = distinct !DILexicalBlock(scope: !102, file: !3, line: 93, column: 7)
!102 = distinct !DILexicalBlock(scope: !95, file: !3, line: 90, column: 5)
!103 = !DILocation(line: 102, column: 24, scope: !102)
!104 = !DILocation(line: 91, column: 24, scope: !102)
!105 = !DILocation(line: 95, column: 33, scope: !106)
!106 = distinct !DILexicalBlock(scope: !107, file: !3, line: 94, column: 9)
!107 = distinct !DILexicalBlock(scope: !101, file: !3, line: 93, column: 7)
!108 = !DILocation(line: 95, column: 22, scope: !106)
!109 = !DILocation(line: 96, column: 21, scope: !106)
!110 = !{!111, !111, i64 0}
!111 = !{!"int", !89, i64 0}
!112 = !DILocation(line: 97, column: 24, scope: !106)
!113 = !{!114, !111, i64 0}
!114 = !{!"vert_st", !111, i64 0, !88, i64 8, !88, i64 16}
!115 = !DILocation(line: 98, column: 27, scope: !106)
!116 = !DILocation(line: 98, column: 16, scope: !106)
!117 = !DILocation(line: 98, column: 25, scope: !106)
!118 = !{!114, !88, i64 16}
!119 = !DILocation(line: 99, column: 16, scope: !106)
!120 = !DILocation(line: 99, column: 21, scope: !106)
!121 = !{!114, !88, i64 8}
!122 = !DILocation(line: 93, column: 29, scope: !107)
!123 = !DILocation(line: 93, column: 18, scope: !107)
!124 = distinct !{!124, !100, !125, !126}
!125 = !DILocation(line: 101, column: 9, scope: !101)
!126 = !{!"llvm.loop.mustprogress"}
!127 = !DILocation(line: 102, column: 7, scope: !102)
!128 = !DILocation(line: 89, column: 28, scope: !95)
!129 = distinct !{!129, !96, !130, !126}
!130 = !DILocation(line: 103, column: 5, scope: !93)
!131 = !DILocation(line: 54, column: 7, scope: !132, inlinedAt: !156)
!132 = distinct !DILexicalBlock(scope: !133, file: !3, line: 54, column: 7)
!133 = distinct !DILexicalBlock(scope: !134, file: !3, line: 53, column: 5)
!134 = distinct !DILexicalBlock(scope: !135, file: !3, line: 52, column: 3)
!135 = distinct !DILexicalBlock(scope: !136, file: !3, line: 52, column: 3)
!136 = distinct !DISubprogram(name: "AddEdges", scope: !3, file: !3, line: 41, type: !137, scopeLine: 43, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !139)
!137 = !DISubroutineType(types: !138)
!138 = !{null, !17, !5, !17, !17, !17, !17}
!139 = !{!140, !141, !142, !143, !144, !145, !146, !147, !148, !149, !152, !153, !154, !155}
!140 = !DILocalVariable(name: "count1", arg: 1, scope: !136, file: !3, line: 41, type: !17)
!141 = !DILocalVariable(name: "retval", arg: 2, scope: !136, file: !3, line: 41, type: !5)
!142 = !DILocalVariable(name: "numproc", arg: 3, scope: !136, file: !3, line: 41, type: !17)
!143 = !DILocalVariable(name: "perproc", arg: 4, scope: !136, file: !3, line: 42, type: !17)
!144 = !DILocalVariable(name: "numvert", arg: 5, scope: !136, file: !3, line: 42, type: !17)
!145 = !DILocalVariable(name: "j", arg: 6, scope: !136, file: !3, line: 42, type: !17)
!146 = !DILocalVariable(name: "tmp", scope: !136, file: !3, line: 44, type: !12)
!147 = !DILocalVariable(name: "helper", scope: !136, file: !3, line: 45, type: !11)
!148 = !DILocalVariable(name: "i", scope: !136, file: !3, line: 46, type: !17)
!149 = !DILocalVariable(name: "pn", scope: !150, file: !3, line: 56, type: !17)
!150 = distinct !DILexicalBlock(scope: !151, file: !3, line: 55, column: 9)
!151 = distinct !DILexicalBlock(scope: !132, file: !3, line: 54, column: 7)
!152 = !DILocalVariable(name: "offset", scope: !150, file: !3, line: 56, type: !17)
!153 = !DILocalVariable(name: "dist", scope: !150, file: !3, line: 56, type: !17)
!154 = !DILocalVariable(name: "dest", scope: !150, file: !3, line: 57, type: !12)
!155 = !DILocalVariable(name: "hash", scope: !150, file: !3, line: 58, type: !20)
!156 = distinct !DILocation(line: 109, column: 7, scope: !157)
!157 = distinct !DILexicalBlock(scope: !158, file: !3, line: 107, column: 5)
!158 = distinct !DILexicalBlock(scope: !99, file: !3, line: 106, column: 3)
!159 = !DILocation(line: 0, scope: !136, inlinedAt: !156)
!160 = !DILocation(line: 52, column: 14, scope: !135, inlinedAt: !156)
!161 = !DILocation(line: 52, scope: !135, inlinedAt: !156)
!162 = !DILocation(line: 52, column: 3, scope: !135, inlinedAt: !156)
!163 = !DILocation(line: 108, column: 17, scope: !157)
!164 = !DILocation(line: 60, column: 16, scope: !165, inlinedAt: !156)
!165 = distinct !DILexicalBlock(scope: !150, file: !3, line: 60, column: 15)
!166 = !DILocation(line: 60, column: 15, scope: !150, inlinedAt: !156)
!167 = !DILocalVariable(name: "i", arg: 1, scope: !168, file: !3, line: 29, type: !17)
!168 = distinct !DISubprogram(name: "compute_dist", scope: !3, file: !3, line: 29, type: !169, scopeLine: 30, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !171)
!169 = !DISubroutineType(types: !170)
!170 = !{!17, !17, !17, !17}
!171 = !{!167, !172, !173, !174, !175}
!172 = !DILocalVariable(name: "j", arg: 2, scope: !168, file: !3, line: 29, type: !17)
!173 = !DILocalVariable(name: "numvert", arg: 3, scope: !168, file: !3, line: 29, type: !17)
!174 = !DILocalVariable(name: "less", scope: !168, file: !3, line: 31, type: !17)
!175 = !DILocalVariable(name: "gt", scope: !168, file: !3, line: 31, type: !17)
!176 = !DILocation(line: 0, scope: !168, inlinedAt: !177)
!177 = distinct !DILocation(line: 62, column: 22, scope: !178, inlinedAt: !156)
!178 = distinct !DILexicalBlock(scope: !165, file: !3, line: 61, column: 13)
!179 = !DILocation(line: 33, column: 23, scope: !168, inlinedAt: !177)
!180 = !DILocation(line: 33, column: 31, scope: !168, inlinedAt: !177)
!181 = !DILocalVariable(name: "seed", arg: 1, scope: !182, file: !3, line: 22, type: !17)
!182 = distinct !DISubprogram(name: "random2", scope: !3, file: !3, line: 22, type: !183, scopeLine: 23, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !185)
!183 = !DISubroutineType(types: !184)
!184 = !{!17, !17}
!185 = !{!181, !186}
!186 = !DILocalVariable(name: "tmp", scope: !182, file: !3, line: 24, type: !17)
!187 = !DILocation(line: 0, scope: !182, inlinedAt: !188)
!188 = distinct !DILocation(line: 33, column: 11, scope: !168, inlinedAt: !177)
!189 = !DILocalVariable(name: "p", arg: 1, scope: !190, file: !3, line: 13, type: !17)
!190 = distinct !DISubprogram(name: "mult", scope: !3, file: !3, line: 13, type: !191, scopeLine: 14, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !193)
!191 = !DISubroutineType(types: !192)
!192 = !{!17, !17, !17}
!193 = !{!189, !194, !195, !196, !197, !198}
!194 = !DILocalVariable(name: "q", arg: 2, scope: !190, file: !3, line: 13, type: !17)
!195 = !DILocalVariable(name: "p1", scope: !190, file: !3, line: 15, type: !17)
!196 = !DILocalVariable(name: "p0", scope: !190, file: !3, line: 15, type: !17)
!197 = !DILocalVariable(name: "q1", scope: !190, file: !3, line: 15, type: !17)
!198 = !DILocalVariable(name: "q0", scope: !190, file: !3, line: 15, type: !17)
!199 = !DILocation(line: 0, scope: !190, inlinedAt: !200)
!200 = distinct !DILocation(line: 25, column: 10, scope: !182, inlinedAt: !188)
!201 = !DILocation(line: 17, column: 8, scope: !190, inlinedAt: !200)
!202 = !DILocation(line: 17, column: 23, scope: !190, inlinedAt: !200)
!203 = !DILocation(line: 19, column: 16, scope: !190, inlinedAt: !200)
!204 = !DILocation(line: 19, column: 22, scope: !190, inlinedAt: !200)
!205 = !DILocation(line: 19, column: 19, scope: !190, inlinedAt: !200)
!206 = !DILocation(line: 19, column: 27, scope: !190, inlinedAt: !200)
!207 = !DILocation(line: 19, column: 38, scope: !190, inlinedAt: !200)
!208 = !DILocation(line: 19, column: 50, scope: !190, inlinedAt: !200)
!209 = !DILocation(line: 19, column: 47, scope: !190, inlinedAt: !200)
!210 = !DILocation(line: 25, column: 28, scope: !182, inlinedAt: !188)
!211 = !DILocation(line: 33, column: 36, scope: !168, inlinedAt: !177)
!212 = !DILocation(line: 33, column: 44, scope: !168, inlinedAt: !177)
!213 = !DILocation(line: 0, scope: !150, inlinedAt: !156)
!214 = !DILocation(line: 64, column: 26, scope: !178, inlinedAt: !156)
!215 = !DILocation(line: 65, column: 35, scope: !178, inlinedAt: !156)
!216 = !DILocation(line: 66, column: 27, scope: !178, inlinedAt: !156)
!217 = !DILocation(line: 67, column: 26, scope: !178, inlinedAt: !156)
!218 = !DILocation(line: 67, column: 40, scope: !178, inlinedAt: !156)
!219 = !DILocation(line: 67, column: 15, scope: !178, inlinedAt: !156)
!220 = !DILocation(line: 69, column: 13, scope: !178, inlinedAt: !156)
!221 = !DILocation(line: 54, column: 37, scope: !151, inlinedAt: !156)
!222 = !DILocation(line: 54, column: 18, scope: !151, inlinedAt: !156)
!223 = distinct !{!223, !131, !224, !126}
!224 = !DILocation(line: 70, column: 9, scope: !132, inlinedAt: !156)
!225 = !DILocation(line: 71, column: 13, scope: !133, inlinedAt: !156)
!226 = !DILocation(line: 52, column: 46, scope: !134, inlinedAt: !156)
!227 = distinct !{!227, !162, !228, !126}
!228 = !DILocation(line: 72, column: 5, scope: !135, inlinedAt: !156)
!229 = !DILocation(line: 106, column: 28, scope: !158)
!230 = !DILocation(line: 106, column: 22, scope: !158)
!231 = distinct !{!231, !98, !232, !126}
!232 = !DILocation(line: 110, column: 5, scope: !99)
!233 = !DILocation(line: 111, column: 3, scope: !66)
!234 = !DILocation(line: 113, column: 3, scope: !66)
!235 = !DILocation(line: 114, column: 3, scope: !66)
!236 = !DISubprogram(name: "malloc", scope: !237, file: !237, line: 540, type: !238, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !243)
!237 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "02258fad21adf111bb9df9825e61954a")
!238 = !DISubroutineType(types: !239)
!239 = !{!34, !240}
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !241, line: 209, baseType: !242)
!241 = !DIFile(filename: "/usr/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "dbf961373c04bf7f9b2509c93f98f3a8")
!242 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!243 = !{}
!244 = !DISubprogram(name: "MakeHash", scope: !21, file: !21, line: 17, type: !245, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !243)
!245 = !DISubroutineType(types: !246)
!246 = !{!20, !17, !37}
!247 = distinct !DISubprogram(name: "hashfunc", scope: !3, file: !3, line: 36, type: !38, scopeLine: 37, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !248)
!248 = !{!249}
!249 = !DILocalVariable(name: "key", arg: 1, scope: !247, file: !3, line: 36, type: !32)
!250 = !DILocation(line: 0, scope: !247)
!251 = !DILocation(line: 38, column: 15, scope: !247)
!252 = !DILocation(line: 38, column: 22, scope: !247)
!253 = !DILocation(line: 38, column: 20, scope: !247)
!254 = !DILocation(line: 38, column: 3, scope: !247)
!255 = !DISubprogram(name: "HashInsert", scope: !21, file: !21, line: 19, type: !256, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !243)
!256 = !DISubroutineType(types: !257)
!257 = !{null, !34, !32, !20}
