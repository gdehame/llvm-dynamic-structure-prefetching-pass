; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.vert_st = type { i32, ptr, ptr }

@.str = private unnamed_addr constant [25 x i8] c"Making graph of size %d\0A\00", align 1, !dbg !0
@NumNodes = external local_unnamed_addr global i32, align 4
@.str.3 = private unnamed_addr constant [17 x i8] c"MST has cost %d\0A\00", align 1, !dbg !7
@MyVertexList = internal unnamed_addr global ptr null, align 8, !dbg !12
@str = private unnamed_addr constant [16 x i8] c"Graph completed\00", align 1
@str.7 = private unnamed_addr constant [22 x i8] c"About to compute mst \00", align 1
@str.8 = private unnamed_addr constant [16 x i8] c"Compute phase 1\00", align 1
@str.9 = private unnamed_addr constant [16 x i8] c"Compute phase 2\00", align 1
@str.11 = private unnamed_addr constant [10 x i8] c"Not found\00", align 1

; Function Attrs: noreturn nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) local_unnamed_addr #0 !dbg !69 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !75, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.value(metadata ptr %1, metadata !76, metadata !DIExpression()), !dbg !88
  %3 = tail call i32 @dealwithargs(i32 noundef %0, ptr noundef %1) #7, !dbg !89
  call void @llvm.dbg.value(metadata i32 %3, metadata !87, metadata !DIExpression()), !dbg !88
  %4 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %3), !dbg !90
  %5 = load i32, ptr @NumNodes, align 4, !dbg !91, !tbaa !92
  %6 = tail call ptr @MakeGraph(i32 noundef %3, i32 noundef %5) #7, !dbg !96
  call void @llvm.dbg.value(metadata ptr %6, metadata !77, metadata !DIExpression()), !dbg !88
  %7 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !97
  %8 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.7), !dbg !98
  %9 = load i32, ptr @NumNodes, align 4, !dbg !99, !tbaa !92
  %10 = tail call fastcc i32 @ComputeMst(ptr noundef %6, i32 noundef %9, i32 noundef %3), !dbg !100
  call void @llvm.dbg.value(metadata i32 %10, metadata !86, metadata !DIExpression()), !dbg !88
  %11 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, i32 noundef %10), !dbg !101
  tail call void @exit(i32 noundef 0) #8, !dbg !102
  unreachable, !dbg !102
}

declare !dbg !103 i32 @dealwithargs(i32 noundef, ptr noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare !dbg !105 noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

declare !dbg !112 ptr @MakeGraph(i32 noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define internal fastcc i32 @ComputeMst(ptr nocapture noundef %0, i32 noundef %1, i32 noundef %2) unnamed_addr #3 !dbg !115 {
  call void @llvm.dbg.value(metadata ptr %0, metadata !119, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 %1, metadata !120, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 %2, metadata !121, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 0, metadata !124, metadata !DIExpression()), !dbg !133
  %4 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.8), !dbg !134
  %5 = load ptr, ptr %0, align 8, !dbg !135, !tbaa !136
  call void @llvm.dbg.value(metadata ptr %5, metadata !122, metadata !DIExpression()), !dbg !133
  %6 = getelementptr inbounds %struct.vert_st, ptr %5, i64 0, i32 1, !dbg !138
  %7 = load ptr, ptr %6, align 8, !dbg !138, !tbaa !139
  call void @llvm.dbg.value(metadata ptr %7, metadata !123, metadata !DIExpression()), !dbg !133
  store ptr %7, ptr %0, align 8, !dbg !141, !tbaa !136
  store ptr %7, ptr @MyVertexList, align 8, !dbg !142, !tbaa !136
  call void @llvm.dbg.value(metadata i32 %2, metadata !121, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !133
  %8 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.9), !dbg !143
  %9 = add nsw i32 %2, -1, !dbg !133
  call void @llvm.dbg.value(metadata i32 %9, metadata !121, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata ptr %5, metadata !122, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 0, metadata !124, metadata !DIExpression()), !dbg !133
  %10 = icmp eq i32 %9, 0, !dbg !144
  br i1 %10, label %21, label %11, !dbg !144

11:                                               ; preds = %3, %11
  %12 = phi i32 [ %19, %11 ], [ %9, %3 ]
  %13 = phi ptr [ %16, %11 ], [ %5, %3 ]
  %14 = phi i32 [ %18, %11 ], [ 0, %3 ]
  call void @llvm.dbg.value(metadata ptr %13, metadata !122, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 %14, metadata !124, metadata !DIExpression()), !dbg !133
  %15 = tail call fastcc { ptr, i32 } @Do_all_BlueRule(ptr noundef %13, i32 noundef %1, i32 noundef 0), !dbg !145
  %16 = extractvalue { ptr, i32 } %15, 0, !dbg !145
  %17 = extractvalue { ptr, i32 } %15, 1, !dbg !145
  call void @llvm.dbg.value(metadata ptr %16, metadata !126, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !146
  call void @llvm.dbg.value(metadata i32 %17, metadata !126, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !146
  call void @llvm.dbg.value(metadata i32 undef, metadata !126, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 32)), !dbg !146
  call void @llvm.dbg.value(metadata ptr %16, metadata !122, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 %17, metadata !125, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 %12, metadata !121, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !133
  %18 = add nsw i32 %17, %14, !dbg !147
  call void @llvm.dbg.value(metadata i32 %18, metadata !124, metadata !DIExpression()), !dbg !133
  %19 = add nsw i32 %12, -1, !dbg !133
  call void @llvm.dbg.value(metadata i32 %19, metadata !121, metadata !DIExpression()), !dbg !133
  %20 = icmp eq i32 %19, 0, !dbg !144
  br i1 %20, label %21, label %11, !dbg !144, !llvm.loop !148

21:                                               ; preds = %11, %3
  %22 = phi i32 [ 0, %3 ], [ %18, %11 ], !dbg !133
  ret i32 %22, !dbg !151
}

; Function Attrs: noreturn nounwind
declare !dbg !152 void @exit(i32 noundef) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
define internal fastcc { ptr, i32 } @Do_all_BlueRule(ptr noundef %0, i32 noundef %1, i32 noundef %2) unnamed_addr #3 !dbg !156 {
  call void @llvm.dbg.value(metadata ptr %0, metadata !160, metadata !DIExpression()), !dbg !169
  call void @llvm.dbg.value(metadata i32 %1, metadata !161, metadata !DIExpression()), !dbg !169
  call void @llvm.dbg.value(metadata i32 %2, metadata !162, metadata !DIExpression()), !dbg !169
  %4 = icmp sgt i32 %1, 1, !dbg !170
  br i1 %4, label %5, label %15, !dbg !172

5:                                                ; preds = %3
  %6 = lshr i32 %1, 1
  %7 = add nsw i32 %6, %2, !dbg !173
  %8 = tail call fastcc { ptr, i32 } @Do_all_BlueRule(ptr noundef %0, i32 noundef %6, i32 noundef %7), !dbg !175
  %9 = extractvalue { ptr, i32 } %8, 1, !dbg !175
  call void @llvm.dbg.value(metadata ptr poison, metadata !163, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !169
  call void @llvm.dbg.value(metadata i32 %9, metadata !163, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !169
  call void @llvm.dbg.value(metadata i32 undef, metadata !163, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 32)), !dbg !169
  %10 = tail call fastcc { ptr, i32 } @Do_all_BlueRule(ptr noundef %0, i32 noundef %6, i32 noundef %2), !dbg !176
  %11 = extractvalue { ptr, i32 } %10, 1, !dbg !176
  call void @llvm.dbg.value(metadata ptr poison, metadata !168, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !169
  call void @llvm.dbg.value(metadata i32 %11, metadata !168, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !169
  call void @llvm.dbg.value(metadata i32 undef, metadata !168, metadata !DIExpression(DW_OP_LLVM_fragment, 96, 32)), !dbg !169
  %12 = icmp slt i32 %9, %11, !dbg !177
  %13 = select i1 %12, { ptr, i32 } %8, { ptr, i32 } %10, !dbg !179
  %14 = tail call i32 @llvm.smin.i32(i32 %9, i32 %11), !dbg !179
  call void @llvm.dbg.value(metadata i32 %14, metadata !168, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !169
  call void @llvm.dbg.value(metadata ptr poison, metadata !168, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !169
  br label %83, !dbg !180

15:                                               ; preds = %3
  %16 = load ptr, ptr @MyVertexList, align 8, !dbg !181, !tbaa !136
  %17 = icmp eq ptr %16, %0, !dbg !184
  br i1 %17, label %18, label %21, !dbg !185

18:                                               ; preds = %15
  %19 = getelementptr inbounds %struct.vert_st, ptr %0, i64 0, i32 1, !dbg !186
  %20 = load ptr, ptr %19, align 8, !dbg !186, !tbaa !139
  store ptr %20, ptr @MyVertexList, align 8, !dbg !187, !tbaa !136
  br label %21, !dbg !188

21:                                               ; preds = %18, %15
  %22 = phi ptr [ %20, %18 ], [ %16, %15 ], !dbg !189
  call void @llvm.dbg.value(metadata ptr %0, metadata !190, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr %22, metadata !195, metadata !DIExpression()), !dbg !209
  %23 = icmp eq ptr %22, null, !dbg !211
  br i1 %23, label %78, label %24, !dbg !213

24:                                               ; preds = %21
  call void @llvm.dbg.value(metadata ptr %22, metadata !198, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr %22, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !209
  %25 = load i32, ptr %22, align 8, !dbg !214, !tbaa !215
  call void @llvm.dbg.value(metadata i32 %25, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !209
  %26 = getelementptr inbounds %struct.vert_st, ptr %22, i64 0, i32 2, !dbg !216
  %27 = load ptr, ptr %26, align 8, !dbg !216, !tbaa !217
  call void @llvm.dbg.value(metadata ptr %27, metadata !199, metadata !DIExpression()), !dbg !209
  %28 = ptrtoint ptr %0 to i64, !dbg !218
  %29 = trunc i64 %28 to i32, !dbg !218
  %30 = tail call ptr @HashLookup(i32 noundef %29, ptr noundef %27) #7, !dbg !219
  %31 = ptrtoint ptr %30 to i64, !dbg !220
  %32 = trunc i64 %31 to i32, !dbg !220
  call void @llvm.dbg.value(metadata i32 %32, metadata !200, metadata !DIExpression()), !dbg !209
  %33 = icmp eq i32 %32, 0, !dbg !221
  br i1 %33, label %37, label %34, !dbg !223

34:                                               ; preds = %24
  %35 = icmp sgt i32 %25, %32, !dbg !224
  br i1 %35, label %36, label %39, !dbg !227

36:                                               ; preds = %34
  store i32 %32, ptr %22, align 8, !dbg !228, !tbaa !215
  call void @llvm.dbg.value(metadata i32 %32, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !209
  br label %39, !dbg !230

37:                                               ; preds = %24
  %38 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11), !dbg !231
  br label %39

39:                                               ; preds = %37, %36, %34
  %40 = phi i32 [ %32, %36 ], [ %25, %34 ], [ %25, %37 ], !dbg !209
  call void @llvm.dbg.value(metadata i32 %40, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !209
  call void @llvm.dbg.value(metadata i32 0, metadata !202, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr poison, metadata !197, metadata !DIExpression()), !dbg !209
  %41 = getelementptr inbounds %struct.vert_st, ptr %22, i64 0, i32 1, !dbg !232
  %42 = load ptr, ptr %41, align 8, !dbg !232, !tbaa !139
  call void @llvm.dbg.value(metadata i32 poison, metadata !202, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr %22, metadata !198, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr %42, metadata !197, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr %22, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !209
  %43 = icmp eq ptr %42, null, !dbg !233
  br i1 %43, label %78, label %44, !dbg !233

44:                                               ; preds = %39
  %45 = getelementptr inbounds %struct.vert_st, ptr %0, i64 0, i32 1
  br label %46, !dbg !233

46:                                               ; preds = %72, %44
  %47 = phi ptr [ %76, %72 ], [ %42, %44 ]
  %48 = phi ptr [ %75, %72 ], [ %41, %44 ]
  %49 = phi i32 [ %74, %72 ], [ %40, %44 ]
  %50 = phi ptr [ %73, %72 ], [ %22, %44 ]
  call void @llvm.dbg.value(metadata i32 %49, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !209
  call void @llvm.dbg.value(metadata ptr %50, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !209
  call void @llvm.dbg.value(metadata i32 poison, metadata !202, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !209
  %51 = icmp eq ptr %47, %0, !dbg !234
  br i1 %51, label %52, label %54, !dbg !235

52:                                               ; preds = %46
  %53 = load ptr, ptr %45, align 8, !dbg !236, !tbaa !139
  call void @llvm.dbg.value(metadata ptr %53, metadata !203, metadata !DIExpression()), !dbg !237
  store ptr %53, ptr %48, align 8, !dbg !238, !tbaa !139
  br label %72, !dbg !239

54:                                               ; preds = %46
  %55 = getelementptr inbounds %struct.vert_st, ptr %47, i64 0, i32 2, !dbg !240
  %56 = load ptr, ptr %55, align 8, !dbg !240, !tbaa !217
  call void @llvm.dbg.value(metadata ptr %56, metadata !199, metadata !DIExpression()), !dbg !209
  %57 = load i32, ptr %47, align 8, !dbg !242, !tbaa !215
  call void @llvm.dbg.value(metadata i32 %57, metadata !201, metadata !DIExpression()), !dbg !209
  %58 = tail call ptr @HashLookup(i32 noundef %29, ptr noundef %56) #7, !dbg !243
  %59 = ptrtoint ptr %58 to i64, !dbg !244
  %60 = trunc i64 %59 to i32, !dbg !244
  call void @llvm.dbg.value(metadata i32 %60, metadata !200, metadata !DIExpression()), !dbg !209
  %61 = icmp eq i32 %60, 0, !dbg !245
  br i1 %61, label %65, label %62, !dbg !247

62:                                               ; preds = %54
  %63 = icmp sgt i32 %57, %60, !dbg !248
  br i1 %63, label %64, label %67, !dbg !251

64:                                               ; preds = %62
  store i32 %60, ptr %47, align 8, !dbg !252, !tbaa !215
  call void @llvm.dbg.value(metadata i32 %60, metadata !201, metadata !DIExpression()), !dbg !209
  br label %67, !dbg !254

65:                                               ; preds = %54
  %66 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.11), !dbg !255
  br label %67

67:                                               ; preds = %65, %64, %62
  %68 = phi i32 [ %60, %64 ], [ %57, %62 ], [ %57, %65 ], !dbg !256
  call void @llvm.dbg.value(metadata i32 %68, metadata !201, metadata !DIExpression()), !dbg !209
  %69 = icmp slt i32 %68, %49, !dbg !257
  %70 = select i1 %69, ptr %47, ptr %50, !dbg !259
  %71 = tail call i32 @llvm.smin.i32(i32 %68, i32 %49), !dbg !259
  br label %72, !dbg !259

72:                                               ; preds = %67, %52
  %73 = phi ptr [ %50, %52 ], [ %70, %67 ], !dbg !209
  %74 = phi i32 [ %49, %52 ], [ %71, %67 ], !dbg !209
  call void @llvm.dbg.value(metadata i32 %74, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !209
  call void @llvm.dbg.value(metadata ptr %73, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !209
  call void @llvm.dbg.value(metadata ptr %47, metadata !198, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr poison, metadata !197, metadata !DIExpression()), !dbg !209
  %75 = getelementptr inbounds %struct.vert_st, ptr %47, i64 0, i32 1, !dbg !232
  %76 = load ptr, ptr %75, align 8, !dbg !232, !tbaa !139
  call void @llvm.dbg.value(metadata i32 %74, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !209
  call void @llvm.dbg.value(metadata i32 poison, metadata !202, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr %76, metadata !197, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.value(metadata ptr %73, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !209
  %77 = icmp eq ptr %76, null, !dbg !233
  br i1 %77, label %78, label %46, !dbg !233, !llvm.loop !260

78:                                               ; preds = %72, %21, %39
  %79 = phi ptr [ undef, %21 ], [ %22, %39 ], [ %73, %72 ]
  %80 = phi i32 [ 999999, %21 ], [ %40, %39 ], [ %74, %72 ], !dbg !209
  call void @llvm.dbg.value(metadata i32 %80, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 32)), !dbg !209
  call void @llvm.dbg.value(metadata ptr %79, metadata !196, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !209
  %81 = insertvalue { ptr, i32 } poison, ptr %79, 0, !dbg !262
  %82 = insertvalue { ptr, i32 } %81, i32 %80, 1, !dbg !262
  br label %83, !dbg !263

83:                                               ; preds = %78, %5
  %84 = phi { ptr, i32 } [ %13, %5 ], [ %82, %78 ]
  %85 = phi i32 [ %14, %5 ], [ %80, %78 ], !dbg !264
  %86 = insertvalue { ptr, i32 } %84, i32 %85, 1, !dbg !265
  ret { ptr, i32 } %86, !dbg !265
}

declare !dbg !266 ptr @HashLookup(i32 noundef, ptr noundef) local_unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #5

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #5

attributes #0 = { noreturn nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nofree nounwind }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }

!llvm.dbg.cu = !{!14}
!llvm.module.flags = !{!62, !63, !64, !65, !66, !67}
!llvm.ident = !{!68}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 144, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "main.c", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "14d595cfd6343daaab9eb3dc7064cca4")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 200, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 25)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !2, line: 153, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 136, elements: !10)
!10 = !{!11}
!11 = !DISubrange(count: 17)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "MyVertexList", scope: !14, file: !2, line: 85, type: !35, isLocal: true, isDefinition: true)
!14 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 16.0.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !15, globals: !18, splitDebugInlining: false, nameTableKind: None)
!15 = !{!16, !17}
!16 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!17 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!18 = !{!0, !19, !21, !7, !26, !28, !12, !30}
!19 = !DIGlobalVariableExpression(var: !20, expr: !DIExpression())
!20 = distinct !DIGlobalVariable(scope: null, file: !2, line: 147, type: !9, isLocal: true, isDefinition: true)
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(scope: null, file: !2, line: 149, type: !23, isLocal: true, isDefinition: true)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 184, elements: !24)
!24 = !{!25}
!25 = !DISubrange(count: 23)
!26 = !DIGlobalVariableExpression(var: !27, expr: !DIExpression())
!27 = distinct !DIGlobalVariable(scope: null, file: !2, line: 114, type: !9, isLocal: true, isDefinition: true)
!28 = !DIGlobalVariableExpression(var: !29, expr: !DIExpression())
!29 = distinct !DIGlobalVariable(scope: null, file: !2, line: 123, type: !9, isLocal: true, isDefinition: true)
!30 = !DIGlobalVariableExpression(var: !31, expr: !DIExpression())
!31 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !32, isLocal: true, isDefinition: true)
!32 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 88, elements: !33)
!33 = !{!34}
!34 = !DISubrange(count: 11)
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "Vertex", file: !36, line: 14, baseType: !37)
!36 = !DIFile(filename: "./mst.h", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "48f1a7db8e821566d507ccb3a3465101")
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vert_st", file: !36, line: 10, size: 192, elements: !39)
!39 = !{!40, !41, !42}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "mindist", scope: !38, file: !36, line: 11, baseType: !16, size: 32)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !38, file: !36, line: 12, baseType: !37, size: 64, offset: 64)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "edgehash", scope: !38, file: !36, line: 13, baseType: !43, size: 64, offset: 128)
!43 = !DIDerivedType(tag: DW_TAG_typedef, name: "Hash", file: !44, line: 15, baseType: !45)
!44 = !DIFile(filename: "./hash.h", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "737edc72d4dc38a7950efc2ecfae2b7e")
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !46, size: 64)
!46 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash", file: !44, line: 11, size: 192, elements: !47)
!47 = !{!48, !58, !61}
!48 = !DIDerivedType(tag: DW_TAG_member, name: "array", scope: !46, file: !44, line: 12, baseType: !49, size: 64)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "HashEntry", file: !44, line: 9, baseType: !51)
!51 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !52, size: 64)
!52 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash_entry", file: !44, line: 5, size: 192, elements: !53)
!53 = !{!54, !55, !57}
!54 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !52, file: !44, line: 6, baseType: !17, size: 32)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "entry", scope: !52, file: !44, line: 7, baseType: !56, size: 64, offset: 64)
!56 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !52, file: !44, line: 8, baseType: !51, size: 64, offset: 128)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "mapfunc", scope: !46, file: !44, line: 13, baseType: !59, size: 64, offset: 64)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DISubroutineType(types: !15)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !46, file: !44, line: 14, baseType: !16, size: 32, offset: 128)
!62 = !{i32 7, !"Dwarf Version", i32 5}
!63 = !{i32 2, !"Debug Info Version", i32 3}
!64 = !{i32 1, !"wchar_size", i32 4}
!65 = !{i32 8, !"PIC Level", i32 2}
!66 = !{i32 7, !"PIE Level", i32 2}
!67 = !{i32 7, !"uwtable", i32 2}
!68 = !{!"clang version 16.0.0"}
!69 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 137, type: !70, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !74)
!70 = !DISubroutineType(types: !71)
!71 = !{!16, !16, !72}
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!74 = !{!75, !76, !77, !86, !87}
!75 = !DILocalVariable(name: "argc", arg: 1, scope: !69, file: !2, line: 137, type: !16)
!76 = !DILocalVariable(name: "argv", arg: 2, scope: !69, file: !2, line: 137, type: !72)
!77 = !DILocalVariable(name: "graph", scope: !69, file: !2, line: 139, type: !78)
!78 = !DIDerivedType(tag: DW_TAG_typedef, name: "Graph", file: !36, line: 18, baseType: !79)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "graph_st", file: !36, line: 16, size: 64, elements: !81)
!81 = !{!82}
!82 = !DIDerivedType(tag: DW_TAG_member, name: "vlist", scope: !80, file: !36, line: 17, baseType: !83, size: 64)
!83 = !DICompositeType(tag: DW_TAG_array_type, baseType: !35, size: 64, elements: !84)
!84 = !{!85}
!85 = !DISubrange(count: 1)
!86 = !DILocalVariable(name: "dist", scope: !69, file: !2, line: 140, type: !16)
!87 = !DILocalVariable(name: "size", scope: !69, file: !2, line: 141, type: !16)
!88 = !DILocation(line: 0, scope: !69)
!89 = !DILocation(line: 143, column: 10, scope: !69)
!90 = !DILocation(line: 144, column: 3, scope: !69)
!91 = !DILocation(line: 146, column: 26, scope: !69)
!92 = !{!93, !93, i64 0}
!93 = !{!"int", !94, i64 0}
!94 = !{!"omnipotent char", !95, i64 0}
!95 = !{!"Simple C/C++ TBAA"}
!96 = !DILocation(line: 146, column: 11, scope: !69)
!97 = !DILocation(line: 147, column: 3, scope: !69)
!98 = !DILocation(line: 149, column: 3, scope: !69)
!99 = !DILocation(line: 151, column: 27, scope: !69)
!100 = !DILocation(line: 151, column: 10, scope: !69)
!101 = !DILocation(line: 153, column: 3, scope: !69)
!102 = !DILocation(line: 154, column: 3, scope: !69)
!103 = !DISubprogram(name: "dealwithargs", scope: !36, file: !36, line: 21, type: !70, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !104)
!104 = !{}
!105 = !DISubprogram(name: "printf", scope: !106, file: !106, line: 356, type: !107, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !104)
!106 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "f31eefcc3f15835fc5a4023a625cf609")
!107 = !DISubroutineType(types: !108)
!108 = !{!16, !109, null}
!109 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !110)
!110 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !111, size: 64)
!111 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
!112 = !DISubprogram(name: "MakeGraph", scope: !36, file: !36, line: 20, type: !113, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !104)
!113 = !DISubroutineType(types: !114)
!114 = !{!78, !16, !16}
!115 = distinct !DISubprogram(name: "ComputeMst", scope: !2, file: !2, line: 108, type: !116, scopeLine: 109, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !118)
!116 = !DISubroutineType(types: !117)
!117 = !{!16, !78, !16, !16}
!118 = !{!119, !120, !121, !122, !123, !124, !125, !126}
!119 = !DILocalVariable(name: "graph", arg: 1, scope: !115, file: !2, line: 108, type: !78)
!120 = !DILocalVariable(name: "numproc", arg: 2, scope: !115, file: !2, line: 108, type: !16)
!121 = !DILocalVariable(name: "numvert", arg: 3, scope: !115, file: !2, line: 108, type: !16)
!122 = !DILocalVariable(name: "inserted", scope: !115, file: !2, line: 110, type: !35)
!123 = !DILocalVariable(name: "tmp", scope: !115, file: !2, line: 110, type: !35)
!124 = !DILocalVariable(name: "cost", scope: !115, file: !2, line: 111, type: !16)
!125 = !DILocalVariable(name: "dist", scope: !115, file: !2, line: 111, type: !16)
!126 = !DILocalVariable(name: "br", scope: !127, file: !2, line: 126, type: !128)
!127 = distinct !DILexicalBlock(scope: !115, file: !2, line: 125, column: 5)
!128 = !DIDerivedType(tag: DW_TAG_typedef, name: "BlueReturn", file: !2, line: 8, baseType: !129)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "blue_return", file: !2, line: 5, size: 128, elements: !130)
!130 = !{!131, !132}
!131 = !DIDerivedType(tag: DW_TAG_member, name: "vert", scope: !129, file: !2, line: 6, baseType: !35, size: 64)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "dist", scope: !129, file: !2, line: 7, baseType: !16, size: 32, offset: 64)
!133 = !DILocation(line: 0, scope: !115)
!134 = !DILocation(line: 114, column: 3, scope: !115)
!135 = !DILocation(line: 117, column: 14, scope: !115)
!136 = !{!137, !137, i64 0}
!137 = !{!"any pointer", !94, i64 0}
!138 = !DILocation(line: 118, column: 19, scope: !115)
!139 = !{!140, !137, i64 8}
!140 = !{!"vert_st", !93, i64 0, !137, i64 8, !137, i64 16}
!141 = !DILocation(line: 119, column: 19, scope: !115)
!142 = !DILocation(line: 120, column: 16, scope: !115)
!143 = !DILocation(line: 123, column: 3, scope: !115)
!144 = !DILocation(line: 124, column: 3, scope: !115)
!145 = !DILocation(line: 128, column: 12, scope: !127)
!146 = !DILocation(line: 0, scope: !127)
!147 = !DILocation(line: 132, column: 18, scope: !127)
!148 = distinct !{!148, !144, !149, !150}
!149 = !DILocation(line: 133, column: 5, scope: !115)
!150 = !{!"llvm.loop.mustprogress"}
!151 = !DILocation(line: 134, column: 3, scope: !115)
!152 = !DISubprogram(name: "exit", scope: !153, file: !153, line: 624, type: !154, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized, retainedNodes: !104)
!153 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "02258fad21adf111bb9df9825e61954a")
!154 = !DISubroutineType(types: !155)
!155 = !{null, !16}
!156 = distinct !DISubprogram(name: "Do_all_BlueRule", scope: !2, file: !2, line: 87, type: !157, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !159)
!157 = !DISubroutineType(types: !158)
!158 = !{!128, !35, !16, !16}
!159 = !{!160, !161, !162, !163, !168}
!160 = !DILocalVariable(name: "inserted", arg: 1, scope: !156, file: !2, line: 87, type: !35)
!161 = !DILocalVariable(name: "nproc", arg: 2, scope: !156, file: !2, line: 87, type: !16)
!162 = !DILocalVariable(name: "pn", arg: 3, scope: !156, file: !2, line: 87, type: !16)
!163 = !DILocalVariable(name: "fcleft", scope: !156, file: !2, line: 88, type: !164)
!164 = !DIDerivedType(tag: DW_TAG_typedef, name: "future_cell_BlueReturn", file: !2, line: 13, baseType: !165)
!165 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fc_br", file: !2, line: 11, size: 128, elements: !166)
!166 = !{!167}
!167 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !165, file: !2, line: 12, baseType: !128, size: 128)
!168 = !DILocalVariable(name: "retright", scope: !156, file: !2, line: 89, type: !128)
!169 = !DILocation(line: 0, scope: !156)
!170 = !DILocation(line: 91, column: 13, scope: !171)
!171 = distinct !DILexicalBlock(scope: !156, file: !2, line: 91, column: 7)
!172 = !DILocation(line: 91, column: 7, scope: !156)
!173 = !DILocation(line: 92, column: 56, scope: !174)
!174 = distinct !DILexicalBlock(scope: !171, file: !2, line: 91, column: 18)
!175 = !DILocation(line: 92, column: 21, scope: !174)
!176 = !DILocation(line: 93, column: 17, scope: !174)
!177 = !DILocation(line: 95, column: 28, scope: !178)
!178 = distinct !DILexicalBlock(scope: !174, file: !2, line: 95, column: 10)
!179 = !DILocation(line: 95, column: 10, scope: !174)
!180 = !DILocation(line: 99, column: 6, scope: !174)
!181 = !DILocation(line: 102, column: 22, scope: !182)
!182 = distinct !DILexicalBlock(scope: !183, file: !2, line: 102, column: 10)
!183 = distinct !DILexicalBlock(scope: !171, file: !2, line: 101, column: 8)
!184 = !DILocation(line: 102, column: 19, scope: !182)
!185 = !DILocation(line: 102, column: 10, scope: !183)
!186 = !DILocation(line: 103, column: 37, scope: !182)
!187 = !DILocation(line: 103, column: 21, scope: !182)
!188 = !DILocation(line: 103, column: 8, scope: !182)
!189 = !DILocation(line: 104, column: 31, scope: !183)
!190 = !DILocalVariable(name: "inserted", arg: 1, scope: !191, file: !2, line: 16, type: !35)
!191 = distinct !DISubprogram(name: "BlueRule", scope: !2, file: !2, line: 16, type: !192, scopeLine: 17, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !194)
!192 = !DISubroutineType(types: !193)
!193 = !{!128, !35, !35}
!194 = !{!190, !195, !196, !197, !198, !199, !200, !201, !202, !203}
!195 = !DILocalVariable(name: "vlist", arg: 2, scope: !191, file: !2, line: 16, type: !35)
!196 = !DILocalVariable(name: "retval", scope: !191, file: !2, line: 18, type: !128)
!197 = !DILocalVariable(name: "tmp", scope: !191, file: !2, line: 19, type: !35)
!198 = !DILocalVariable(name: "prev", scope: !191, file: !2, line: 19, type: !35)
!199 = !DILocalVariable(name: "hash", scope: !191, file: !2, line: 20, type: !43)
!200 = !DILocalVariable(name: "dist", scope: !191, file: !2, line: 21, type: !16)
!201 = !DILocalVariable(name: "dist2", scope: !191, file: !2, line: 21, type: !16)
!202 = !DILocalVariable(name: "count", scope: !191, file: !2, line: 22, type: !16)
!203 = !DILocalVariable(name: "next", scope: !204, file: !2, line: 52, type: !35)
!204 = distinct !DILexicalBlock(scope: !205, file: !2, line: 51, column: 9)
!205 = distinct !DILexicalBlock(scope: !206, file: !2, line: 50, column: 11)
!206 = distinct !DILexicalBlock(scope: !207, file: !2, line: 48, column: 5)
!207 = distinct !DILexicalBlock(scope: !208, file: !2, line: 47, column: 3)
!208 = distinct !DILexicalBlock(scope: !191, file: !2, line: 47, column: 3)
!209 = !DILocation(line: 0, scope: !191, inlinedAt: !210)
!210 = distinct !DILocation(line: 104, column: 13, scope: !183)
!211 = !DILocation(line: 24, column: 8, scope: !212, inlinedAt: !210)
!212 = distinct !DILexicalBlock(scope: !191, file: !2, line: 24, column: 7)
!213 = !DILocation(line: 24, column: 7, scope: !191, inlinedAt: !210)
!214 = !DILocation(line: 31, column: 24, scope: !191, inlinedAt: !210)
!215 = !{!140, !93, i64 0}
!216 = !DILocation(line: 32, column: 17, scope: !191, inlinedAt: !210)
!217 = !{!140, !137, i64 16}
!218 = !DILocation(line: 33, column: 27, scope: !191, inlinedAt: !210)
!219 = !DILocation(line: 33, column: 16, scope: !191, inlinedAt: !210)
!220 = !DILocation(line: 33, column: 10, scope: !191, inlinedAt: !210)
!221 = !DILocation(line: 35, column: 7, scope: !222, inlinedAt: !210)
!222 = distinct !DILexicalBlock(scope: !191, file: !2, line: 35, column: 7)
!223 = !DILocation(line: 35, column: 7, scope: !191, inlinedAt: !210)
!224 = !DILocation(line: 37, column: 15, scope: !225, inlinedAt: !210)
!225 = distinct !DILexicalBlock(scope: !226, file: !2, line: 37, column: 11)
!226 = distinct !DILexicalBlock(scope: !222, file: !2, line: 36, column: 5)
!227 = !DILocation(line: 37, column: 11, scope: !226, inlinedAt: !210)
!228 = !DILocation(line: 39, column: 26, scope: !229, inlinedAt: !210)
!229 = distinct !DILexicalBlock(scope: !225, file: !2, line: 38, column: 9)
!230 = !DILocation(line: 41, column: 9, scope: !229, inlinedAt: !210)
!231 = !DILocation(line: 43, column: 8, scope: !222, inlinedAt: !210)
!232 = !DILocation(line: 47, scope: !208, inlinedAt: !210)
!233 = !DILocation(line: 47, column: 3, scope: !208, inlinedAt: !210)
!234 = !DILocation(line: 50, column: 14, scope: !205, inlinedAt: !210)
!235 = !DILocation(line: 50, column: 11, scope: !206, inlinedAt: !210)
!236 = !DILocation(line: 54, column: 23, scope: !204, inlinedAt: !210)
!237 = !DILocation(line: 0, scope: !204, inlinedAt: !210)
!238 = !DILocation(line: 55, column: 22, scope: !204, inlinedAt: !210)
!239 = !DILocation(line: 56, column: 9, scope: !204, inlinedAt: !210)
!240 = !DILocation(line: 59, column: 23, scope: !241, inlinedAt: !210)
!241 = distinct !DILexicalBlock(scope: !205, file: !2, line: 58, column: 9)
!242 = !DILocation(line: 60, column: 24, scope: !241, inlinedAt: !210)
!243 = !DILocation(line: 61, column: 24, scope: !241, inlinedAt: !210)
!244 = !DILocation(line: 61, column: 18, scope: !241, inlinedAt: !210)
!245 = !DILocation(line: 63, column: 15, scope: !246, inlinedAt: !210)
!246 = distinct !DILexicalBlock(scope: !241, file: !2, line: 63, column: 15)
!247 = !DILocation(line: 63, column: 15, scope: !241, inlinedAt: !210)
!248 = !DILocation(line: 65, column: 23, scope: !249, inlinedAt: !210)
!249 = distinct !DILexicalBlock(scope: !250, file: !2, line: 65, column: 19)
!250 = distinct !DILexicalBlock(scope: !246, file: !2, line: 64, column: 13)
!251 = !DILocation(line: 65, column: 19, scope: !250, inlinedAt: !210)
!252 = !DILocation(line: 67, column: 32, scope: !253, inlinedAt: !210)
!253 = distinct !DILexicalBlock(scope: !249, file: !2, line: 66, column: 17)
!254 = !DILocation(line: 69, column: 17, scope: !253, inlinedAt: !210)
!255 = !DILocation(line: 71, column: 16, scope: !246, inlinedAt: !210)
!256 = !DILocation(line: 0, scope: !241, inlinedAt: !210)
!257 = !DILocation(line: 72, column: 20, scope: !258, inlinedAt: !210)
!258 = distinct !DILexicalBlock(scope: !241, file: !2, line: 72, column: 15)
!259 = !DILocation(line: 72, column: 15, scope: !241, inlinedAt: !210)
!260 = distinct !{!260, !233, !261, !150}
!261 = !DILocation(line: 78, column: 5, scope: !208, inlinedAt: !210)
!262 = !DILocation(line: 81, column: 1, scope: !191, inlinedAt: !210)
!263 = !DILocation(line: 104, column: 6, scope: !183)
!264 = !DILocation(line: 0, scope: !171)
!265 = !DILocation(line: 106, column: 1, scope: !156)
!266 = !DISubprogram(name: "HashLookup", scope: !44, file: !44, line: 18, type: !267, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !104)
!267 = !DISubroutineType(types: !268)
!268 = !{!56, !17, !43}
