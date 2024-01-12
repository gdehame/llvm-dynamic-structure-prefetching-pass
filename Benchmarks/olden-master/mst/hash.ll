; ModuleID = 'hash.c'
source_filename = "hash.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.hash = type { ptr, ptr, i32 }
%struct.hash_entry = type { i32, ptr, ptr }

@.str = private unnamed_addr constant [30 x i8] c"Assertion failure:%d in hash\0A\00", align 1, !dbg !0
@remaining = internal unnamed_addr global i32 0, align 4, !dbg !7
@temp = internal unnamed_addr global ptr null, align 8, !dbg !40
@str = private unnamed_addr constant [27 x i8] c"Error! malloc returns null\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local ptr @MakeHash(i32 noundef %0, ptr noundef %1) local_unnamed_addr #0 !dbg !49 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !53, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.value(metadata ptr %1, metadata !54, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.value(metadata i32 24, metadata !58, metadata !DIExpression()), !dbg !64
  %3 = load i32, ptr @remaining, align 4, !dbg !66, !tbaa !68
  %4 = icmp slt i32 %3, 24, !dbg !72
  br i1 %4, label %5, label %10, !dbg !73

5:                                                ; preds = %2
  %6 = tail call noalias dereferenceable_or_null(32768) ptr @malloc(i64 noundef 32768) #7, !dbg !74
  store ptr %6, ptr @temp, align 8, !dbg !76, !tbaa !77
  %7 = icmp eq ptr %6, null, !dbg !79
  br i1 %7, label %8, label %10, !dbg !81

8:                                                ; preds = %5
  %9 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !82
  br label %10, !dbg !82

10:                                               ; preds = %2, %5, %8
  %11 = phi i32 [ %3, %2 ], [ 32768, %8 ], [ 32768, %5 ], !dbg !83
  %12 = load ptr, ptr @temp, align 8, !dbg !84, !tbaa !77
  call void @llvm.dbg.value(metadata ptr %12, metadata !63, metadata !DIExpression()), !dbg !64
  %13 = getelementptr inbounds i8, ptr %12, i64 24, !dbg !85
  %14 = add nsw i32 %11, -24, !dbg !83
  store i32 %14, ptr @remaining, align 4, !dbg !83, !tbaa !68
  call void @llvm.dbg.value(metadata ptr %12, metadata !55, metadata !DIExpression()), !dbg !57
  %15 = shl i32 %0, 3, !dbg !86
  call void @llvm.dbg.value(metadata i32 %15, metadata !58, metadata !DIExpression()), !dbg !87
  %16 = icmp slt i32 %14, %15, !dbg !89
  br i1 %16, label %17, label %23, !dbg !90

17:                                               ; preds = %10
  %18 = tail call noalias dereferenceable_or_null(32768) ptr @malloc(i64 noundef 32768) #7, !dbg !91
  store ptr %18, ptr @temp, align 8, !dbg !92, !tbaa !77
  %19 = icmp eq ptr %18, null, !dbg !93
  br i1 %19, label %20, label %23, !dbg !94

20:                                               ; preds = %17
  %21 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !95
  %22 = load ptr, ptr @temp, align 8, !dbg !96, !tbaa !77
  br label %23, !dbg !95

23:                                               ; preds = %10, %17, %20
  %24 = phi ptr [ %13, %10 ], [ %22, %20 ], [ %18, %17 ], !dbg !96
  %25 = phi i32 [ %14, %10 ], [ 32768, %20 ], [ 32768, %17 ], !dbg !97
  call void @llvm.dbg.value(metadata ptr %24, metadata !63, metadata !DIExpression()), !dbg !87
  %26 = sext i32 %15 to i64, !dbg !98
  %27 = getelementptr inbounds i8, ptr %24, i64 %26, !dbg !98
  store ptr %27, ptr @temp, align 8, !dbg !98, !tbaa !77
  %28 = sub nsw i32 %25, %15, !dbg !97
  store i32 %28, ptr @remaining, align 4, !dbg !97, !tbaa !68
  store ptr %24, ptr %12, align 8, !dbg !99, !tbaa !100
  call void @llvm.dbg.value(metadata i32 0, metadata !56, metadata !DIExpression()), !dbg !57
  %29 = icmp sgt i32 %0, 0, !dbg !102
  br i1 %29, label %30, label %64, !dbg !105

30:                                               ; preds = %23
  %31 = zext i32 %0 to i64, !dbg !102
  %32 = and i64 %31, 3, !dbg !105
  %33 = icmp ult i32 %0, 4, !dbg !105
  br i1 %33, label %53, label %34, !dbg !105

34:                                               ; preds = %30
  %35 = and i64 %31, 4294967292, !dbg !105
  br label %36, !dbg !105

36:                                               ; preds = %36, %34
  %37 = phi i64 [ 0, %34 ], [ %50, %36 ]
  %38 = phi i64 [ 0, %34 ], [ %51, %36 ]
  call void @llvm.dbg.value(metadata i64 %37, metadata !56, metadata !DIExpression()), !dbg !57
  %39 = load ptr, ptr %12, align 8, !dbg !106, !tbaa !100
  %40 = getelementptr inbounds ptr, ptr %39, i64 %37, !dbg !107
  store ptr null, ptr %40, align 8, !dbg !108, !tbaa !77
  %41 = or i64 %37, 1, !dbg !109
  call void @llvm.dbg.value(metadata i64 %41, metadata !56, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.value(metadata i64 %41, metadata !56, metadata !DIExpression()), !dbg !57
  %42 = load ptr, ptr %12, align 8, !dbg !106, !tbaa !100
  %43 = getelementptr inbounds ptr, ptr %42, i64 %41, !dbg !107
  store ptr null, ptr %43, align 8, !dbg !108, !tbaa !77
  %44 = or i64 %37, 2, !dbg !109
  call void @llvm.dbg.value(metadata i64 %44, metadata !56, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.value(metadata i64 %44, metadata !56, metadata !DIExpression()), !dbg !57
  %45 = load ptr, ptr %12, align 8, !dbg !106, !tbaa !100
  %46 = getelementptr inbounds ptr, ptr %45, i64 %44, !dbg !107
  store ptr null, ptr %46, align 8, !dbg !108, !tbaa !77
  %47 = or i64 %37, 3, !dbg !109
  call void @llvm.dbg.value(metadata i64 %47, metadata !56, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.value(metadata i64 %47, metadata !56, metadata !DIExpression()), !dbg !57
  %48 = load ptr, ptr %12, align 8, !dbg !106, !tbaa !100
  %49 = getelementptr inbounds ptr, ptr %48, i64 %47, !dbg !107
  store ptr null, ptr %49, align 8, !dbg !108, !tbaa !77
  %50 = add nuw nsw i64 %37, 4, !dbg !109
  call void @llvm.dbg.value(metadata i64 %50, metadata !56, metadata !DIExpression()), !dbg !57
  %51 = add i64 %38, 4, !dbg !105
  %52 = icmp eq i64 %51, %35, !dbg !105
  br i1 %52, label %53, label %36, !dbg !105, !llvm.loop !110

53:                                               ; preds = %36, %30
  %54 = phi i64 [ 0, %30 ], [ %50, %36 ]
  %55 = icmp eq i64 %32, 0, !dbg !105
  br i1 %55, label %64, label %56, !dbg !105

56:                                               ; preds = %53, %56
  %57 = phi i64 [ %61, %56 ], [ %54, %53 ]
  %58 = phi i64 [ %62, %56 ], [ 0, %53 ]
  call void @llvm.dbg.value(metadata i64 %57, metadata !56, metadata !DIExpression()), !dbg !57
  %59 = load ptr, ptr %12, align 8, !dbg !106, !tbaa !100
  %60 = getelementptr inbounds ptr, ptr %59, i64 %57, !dbg !107
  store ptr null, ptr %60, align 8, !dbg !108, !tbaa !77
  %61 = add nuw nsw i64 %57, 1, !dbg !109
  call void @llvm.dbg.value(metadata i64 %61, metadata !56, metadata !DIExpression()), !dbg !57
  %62 = add i64 %58, 1, !dbg !105
  %63 = icmp eq i64 %62, %32, !dbg !105
  br i1 %63, label %64, label %56, !dbg !105, !llvm.loop !113

64:                                               ; preds = %53, %56, %23
  %65 = getelementptr inbounds %struct.hash, ptr %12, i64 0, i32 1, !dbg !115
  store ptr %1, ptr %65, align 8, !dbg !116, !tbaa !117
  %66 = getelementptr inbounds %struct.hash, ptr %12, i64 0, i32 2, !dbg !118
  store i32 %0, ptr %66, align 8, !dbg !119, !tbaa !120
  ret ptr %12, !dbg !121
}

; Function Attrs: nounwind uwtable
define dso_local ptr @HashLookup(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #1 !dbg !122 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !126, metadata !DIExpression()), !dbg !130
  call void @llvm.dbg.value(metadata ptr %1, metadata !127, metadata !DIExpression()), !dbg !130
  %3 = getelementptr inbounds %struct.hash, ptr %1, i64 0, i32 1, !dbg !131
  %4 = load ptr, ptr %3, align 8, !dbg !131, !tbaa !117
  %5 = tail call i32 %4(i32 noundef %0) #8, !dbg !132
  call void @llvm.dbg.value(metadata i32 %5, metadata !128, metadata !DIExpression()), !dbg !130
  %6 = icmp sgt i32 %5, -1, !dbg !133
  br i1 %6, label %9, label %7, !dbg !135

7:                                                ; preds = %2
  %8 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 1), !dbg !136
  tail call void @exit(i32 noundef -1) #9, !dbg !136
  unreachable, !dbg !136

9:                                                ; preds = %2
  %10 = getelementptr inbounds %struct.hash, ptr %1, i64 0, i32 2, !dbg !138
  %11 = load i32, ptr %10, align 8, !dbg !138, !tbaa !120
  %12 = icmp slt i32 %5, %11, !dbg !138
  br i1 %12, label %15, label %13, !dbg !140

13:                                               ; preds = %9
  %14 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 2), !dbg !141
  tail call void @exit(i32 noundef -1) #9, !dbg !141
  unreachable, !dbg !141

15:                                               ; preds = %9
  %16 = load ptr, ptr %1, align 8, !dbg !143, !tbaa !100
  %17 = zext i32 %5 to i64
  %18 = getelementptr inbounds ptr, ptr %16, i64 %17, !dbg !145
  call void @llvm.dbg.value(metadata ptr poison, metadata !129, metadata !DIExpression()), !dbg !130
  %19 = load ptr, ptr %18, align 8, !dbg !146, !tbaa !77
  call void @llvm.dbg.value(metadata ptr %19, metadata !129, metadata !DIExpression()), !dbg !130
  %20 = icmp eq ptr %19, null, !dbg !147
  br i1 %20, label %32, label %21, !dbg !149

21:                                               ; preds = %15, %25
  %22 = phi ptr [ %27, %25 ], [ %19, %15 ]
  %23 = load i32, ptr %22, align 8, !dbg !150, !tbaa !151
  %24 = icmp eq i32 %23, %0, !dbg !153
  br i1 %24, label %29, label %25, !dbg !154

25:                                               ; preds = %21
  %26 = getelementptr inbounds %struct.hash_entry, ptr %22, i64 0, i32 2, !dbg !155
  call void @llvm.dbg.value(metadata ptr poison, metadata !129, metadata !DIExpression()), !dbg !130
  %27 = load ptr, ptr %26, align 8, !dbg !146, !tbaa !77
  call void @llvm.dbg.value(metadata ptr %27, metadata !129, metadata !DIExpression()), !dbg !130
  %28 = icmp eq ptr %27, null, !dbg !147
  br i1 %28, label %32, label %21, !dbg !149, !llvm.loop !156

29:                                               ; preds = %21
  %30 = getelementptr inbounds %struct.hash_entry, ptr %22, i64 0, i32 1, !dbg !158
  %31 = load ptr, ptr %30, align 8, !dbg !158, !tbaa !160
  br label %32, !dbg !161

32:                                               ; preds = %25, %15, %29
  %33 = phi ptr [ %31, %29 ], [ null, %15 ], [ null, %25 ], !dbg !130
  ret ptr %33, !dbg !162
}

; Function Attrs: nofree nounwind
declare !dbg !163 noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: noreturn nounwind
declare !dbg !171 void @exit(i32 noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local void @HashInsert(ptr noundef %0, i32 noundef %1, ptr nocapture noundef readonly %2) local_unnamed_addr #1 !dbg !175 {
  call void @llvm.dbg.value(metadata ptr %0, metadata !179, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.value(metadata i32 %1, metadata !180, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.value(metadata ptr %2, metadata !181, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.value(metadata i32 %1, metadata !126, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata ptr %2, metadata !127, metadata !DIExpression()), !dbg !185
  %4 = getelementptr inbounds %struct.hash, ptr %2, i64 0, i32 1, !dbg !188
  %5 = load ptr, ptr %4, align 8, !dbg !188, !tbaa !117
  %6 = tail call i32 %5(i32 noundef %1) #8, !dbg !189
  call void @llvm.dbg.value(metadata i32 %6, metadata !128, metadata !DIExpression()), !dbg !185
  %7 = icmp sgt i32 %6, -1, !dbg !190
  br i1 %7, label %10, label %8, !dbg !191

8:                                                ; preds = %3
  %9 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 1), !dbg !192
  tail call void @exit(i32 noundef -1) #9, !dbg !192
  unreachable, !dbg !192

10:                                               ; preds = %3
  %11 = getelementptr inbounds %struct.hash, ptr %2, i64 0, i32 2, !dbg !193
  %12 = load i32, ptr %11, align 8, !dbg !193, !tbaa !120
  %13 = icmp slt i32 %6, %12, !dbg !193
  br i1 %13, label %16, label %14, !dbg !194

14:                                               ; preds = %10
  %15 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 2), !dbg !195
  tail call void @exit(i32 noundef -1) #9, !dbg !195
  unreachable, !dbg !195

16:                                               ; preds = %10
  %17 = load ptr, ptr %2, align 8, !dbg !196, !tbaa !100
  %18 = zext i32 %6 to i64
  %19 = getelementptr inbounds ptr, ptr %17, i64 %18, !dbg !197
  call void @llvm.dbg.value(metadata ptr poison, metadata !129, metadata !DIExpression()), !dbg !185
  %20 = load ptr, ptr %19, align 8, !dbg !198, !tbaa !77
  call void @llvm.dbg.value(metadata ptr %20, metadata !129, metadata !DIExpression()), !dbg !185
  %21 = icmp eq ptr %20, null, !dbg !199
  br i1 %21, label %36, label %22, !dbg !200

22:                                               ; preds = %16, %26
  %23 = phi ptr [ %28, %26 ], [ %20, %16 ]
  %24 = load i32, ptr %23, align 8, !dbg !201, !tbaa !151
  %25 = icmp eq i32 %24, %1, !dbg !202
  br i1 %25, label %30, label %26, !dbg !203

26:                                               ; preds = %22
  %27 = getelementptr inbounds %struct.hash_entry, ptr %23, i64 0, i32 2, !dbg !204
  call void @llvm.dbg.value(metadata ptr poison, metadata !129, metadata !DIExpression()), !dbg !185
  %28 = load ptr, ptr %27, align 8, !dbg !198, !tbaa !77
  call void @llvm.dbg.value(metadata ptr %28, metadata !129, metadata !DIExpression()), !dbg !185
  %29 = icmp eq ptr %28, null, !dbg !199
  br i1 %29, label %36, label %22, !dbg !200, !llvm.loop !205

30:                                               ; preds = %22
  %31 = getelementptr inbounds %struct.hash_entry, ptr %23, i64 0, i32 1, !dbg !207
  %32 = load ptr, ptr %31, align 8, !dbg !207, !tbaa !160
  %33 = icmp eq ptr %32, null, !dbg !208
  br i1 %33, label %36, label %34, !dbg !209

34:                                               ; preds = %30
  %35 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 3), !dbg !210
  tail call void @exit(i32 noundef -1) #9, !dbg !210
  unreachable, !dbg !210

36:                                               ; preds = %26, %16, %30
  %37 = load ptr, ptr %4, align 8, !dbg !212, !tbaa !117
  %38 = tail call i32 %37(i32 noundef %1) #8, !dbg !213
  call void @llvm.dbg.value(metadata i32 %38, metadata !183, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.value(metadata i32 24, metadata !58, metadata !DIExpression()), !dbg !214
  %39 = load i32, ptr @remaining, align 4, !dbg !216, !tbaa !68
  %40 = icmp slt i32 %39, 24, !dbg !217
  br i1 %40, label %41, label %46, !dbg !218

41:                                               ; preds = %36
  %42 = tail call noalias dereferenceable_or_null(32768) ptr @malloc(i64 noundef 32768) #7, !dbg !219
  store ptr %42, ptr @temp, align 8, !dbg !220, !tbaa !77
  %43 = icmp eq ptr %42, null, !dbg !221
  br i1 %43, label %44, label %46, !dbg !222

44:                                               ; preds = %41
  %45 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !223
  br label %46, !dbg !223

46:                                               ; preds = %36, %41, %44
  %47 = phi i32 [ %39, %36 ], [ 32768, %44 ], [ 32768, %41 ], !dbg !224
  %48 = load ptr, ptr @temp, align 8, !dbg !225, !tbaa !77
  call void @llvm.dbg.value(metadata ptr %48, metadata !63, metadata !DIExpression()), !dbg !214
  %49 = getelementptr inbounds i8, ptr %48, i64 24, !dbg !226
  store ptr %49, ptr @temp, align 8, !dbg !226, !tbaa !77
  %50 = add nsw i32 %47, -24, !dbg !224
  store i32 %50, ptr @remaining, align 4, !dbg !224, !tbaa !68
  call void @llvm.dbg.value(metadata ptr %48, metadata !182, metadata !DIExpression()), !dbg !184
  %51 = load ptr, ptr %2, align 8, !dbg !227, !tbaa !100
  %52 = sext i32 %38 to i64, !dbg !228
  %53 = getelementptr inbounds ptr, ptr %51, i64 %52, !dbg !228
  %54 = load ptr, ptr %53, align 8, !dbg !228, !tbaa !77
  %55 = getelementptr inbounds %struct.hash_entry, ptr %48, i64 0, i32 2, !dbg !229
  store ptr %54, ptr %55, align 8, !dbg !230, !tbaa !231
  store ptr %48, ptr %53, align 8, !dbg !232, !tbaa !77
  store i32 %1, ptr %48, align 8, !dbg !233, !tbaa !151
  %56 = getelementptr inbounds %struct.hash_entry, ptr %48, i64 0, i32 1, !dbg !234
  store ptr %0, ptr %56, align 8, !dbg !235, !tbaa !160
  ret void, !dbg !236
}

; Function Attrs: nounwind uwtable
define dso_local void @HashDelete(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #1 !dbg !237 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !241, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata ptr %1, metadata !242, metadata !DIExpression()), !dbg !246
  %3 = getelementptr inbounds %struct.hash, ptr %1, i64 0, i32 1, !dbg !247
  %4 = load ptr, ptr %3, align 8, !dbg !247, !tbaa !117
  %5 = tail call i32 %4(i32 noundef %0) #8, !dbg !248
  call void @llvm.dbg.value(metadata i32 %5, metadata !244, metadata !DIExpression()), !dbg !246
  %6 = load ptr, ptr %1, align 8, !dbg !249, !tbaa !100
  %7 = sext i32 %5 to i64, !dbg !250
  %8 = getelementptr inbounds ptr, ptr %6, i64 %7, !dbg !250
  call void @llvm.dbg.value(metadata ptr %8, metadata !245, metadata !DIExpression()), !dbg !246
  %9 = load ptr, ptr %8, align 8, !dbg !251, !tbaa !77
  %10 = icmp eq ptr %9, null, !dbg !251
  br i1 %10, label %22, label %11, !dbg !252

11:                                               ; preds = %2
  call void @llvm.dbg.value(metadata ptr %8, metadata !245, metadata !DIExpression()), !dbg !246
  %12 = load i32, ptr %9, align 8, !dbg !253, !tbaa !151
  %13 = icmp eq i32 %12, %0, !dbg !254
  br i1 %13, label %26, label %17, !dbg !255

14:                                               ; preds = %17
  call void @llvm.dbg.value(metadata ptr %19, metadata !245, metadata !DIExpression()), !dbg !246
  %15 = load i32, ptr %20, align 8, !dbg !253, !tbaa !151
  %16 = icmp eq i32 %15, %0, !dbg !254
  br i1 %16, label %24, label %17, !dbg !255, !llvm.loop !256

17:                                               ; preds = %11, %14
  %18 = phi ptr [ %20, %14 ], [ %9, %11 ]
  %19 = getelementptr inbounds %struct.hash_entry, ptr %18, i64 0, i32 2, !dbg !258
  call void @llvm.dbg.value(metadata ptr %19, metadata !245, metadata !DIExpression()), !dbg !246
  %20 = load ptr, ptr %19, align 8, !dbg !251, !tbaa !77
  %21 = icmp eq ptr %20, null, !dbg !251
  br i1 %21, label %22, label %14, !dbg !252, !llvm.loop !256

22:                                               ; preds = %17, %2
  %23 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 4), !dbg !260
  tail call void @exit(i32 noundef -1) #9, !dbg !260
  unreachable, !dbg !260

24:                                               ; preds = %14
  %25 = getelementptr inbounds %struct.hash_entry, ptr %18, i64 0, i32 2, !dbg !258
  br label %26, !dbg !263

26:                                               ; preds = %24, %11
  %27 = phi ptr [ %9, %11 ], [ %20, %24 ]
  %28 = phi ptr [ %8, %11 ], [ %25, %24 ]
  call void @llvm.dbg.value(metadata ptr poison, metadata !243, metadata !DIExpression()), !dbg !246
  %29 = getelementptr inbounds %struct.hash_entry, ptr %27, i64 0, i32 2, !dbg !263
  %30 = load ptr, ptr %29, align 8, !dbg !263, !tbaa !231
  store ptr %30, ptr %28, align 8, !dbg !264, !tbaa !77
  ret void, !dbg !265
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !266 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #5

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #6

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nofree nounwind }
attributes #7 = { nounwind allocsize(0) }
attributes #8 = { nounwind }
attributes #9 = { noreturn nounwind }

!llvm.dbg.cu = !{!9}
!llvm.module.flags = !{!42, !43, !44, !45, !46, !47}
!llvm.ident = !{!48}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 49, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "hash.c", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "74f08835d78245a4240c353db95b8b88")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 30)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(name: "remaining", scope: !9, file: !2, line: 8, type: !31, isLocal: true, isDefinition: true)
!9 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 16.0.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !10, globals: !34, splitDebugInlining: false, nameTableKind: None)
!10 = !{!11, !17, !25, !18, !33}
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "Hash", file: !12, line: 15, baseType: !13)
!12 = !DIFile(filename: "./hash.h", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "737edc72d4dc38a7950efc2ecfae2b7e")
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash", file: !12, line: 11, size: 192, elements: !15)
!15 = !{!16, !27, !32}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "array", scope: !14, file: !12, line: 12, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "HashEntry", file: !12, line: 9, baseType: !19)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash_entry", file: !12, line: 5, size: 192, elements: !21)
!21 = !{!22, !24, !26}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !20, file: !12, line: 6, baseType: !23, size: 32)
!23 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "entry", scope: !20, file: !12, line: 7, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !20, file: !12, line: 8, baseType: !19, size: 64, offset: 128)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "mapfunc", scope: !14, file: !12, line: 13, baseType: !28, size: 64, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DISubroutineType(types: !30)
!30 = !{!31, !23}
!31 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !14, file: !12, line: 14, baseType: !31, size: 32, offset: 128)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!34 = !{!0, !35, !7, !40}
!35 = !DIGlobalVariableExpression(var: !36, expr: !DIExpression())
!36 = distinct !DIGlobalVariable(scope: null, file: !2, line: 18, type: !37, isLocal: true, isDefinition: true)
!37 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 224, elements: !38)
!38 = !{!39}
!39 = !DISubrange(count: 28)
!40 = !DIGlobalVariableExpression(var: !41, expr: !DIExpression())
!41 = distinct !DIGlobalVariable(name: "temp", scope: !9, file: !2, line: 9, type: !33, isLocal: true, isDefinition: true)
!42 = !{i32 7, !"Dwarf Version", i32 5}
!43 = !{i32 2, !"Debug Info Version", i32 3}
!44 = !{i32 1, !"wchar_size", i32 4}
!45 = !{i32 8, !"PIC Level", i32 2}
!46 = !{i32 7, !"PIE Level", i32 2}
!47 = !{i32 7, !"uwtable", i32 2}
!48 = !{!"clang version 16.0.0"}
!49 = distinct !DISubprogram(name: "MakeHash", scope: !2, file: !2, line: 29, type: !50, scopeLine: 30, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !9, retainedNodes: !52)
!50 = !DISubroutineType(types: !51)
!51 = !{!11, !31, !28}
!52 = !{!53, !54, !55, !56}
!53 = !DILocalVariable(name: "size", arg: 1, scope: !49, file: !2, line: 29, type: !31)
!54 = !DILocalVariable(name: "map", arg: 2, scope: !49, file: !2, line: 29, type: !28)
!55 = !DILocalVariable(name: "retval", scope: !49, file: !2, line: 31, type: !11)
!56 = !DILocalVariable(name: "i", scope: !49, file: !2, line: 32, type: !31)
!57 = !DILocation(line: 0, scope: !49)
!58 = !DILocalVariable(name: "size", arg: 1, scope: !59, file: !2, line: 11, type: !31)
!59 = distinct !DISubprogram(name: "localmalloc", scope: !2, file: !2, line: 11, type: !60, scopeLine: 12, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !9, retainedNodes: !62)
!60 = !DISubroutineType(types: !61)
!61 = !{!33, !31}
!62 = !{!58, !63}
!63 = !DILocalVariable(name: "blah", scope: !59, file: !2, line: 13, type: !33)
!64 = !DILocation(line: 0, scope: !59, inlinedAt: !65)
!65 = distinct !DILocation(line: 34, column: 19, scope: !49)
!66 = !DILocation(line: 15, column: 12, scope: !67, inlinedAt: !65)
!67 = distinct !DILexicalBlock(scope: !59, file: !2, line: 15, column: 7)
!68 = !{!69, !69, i64 0}
!69 = !{!"int", !70, i64 0}
!70 = !{!"omnipotent char", !71, i64 0}
!71 = !{!"Simple C/C++ TBAA"}
!72 = !DILocation(line: 15, column: 11, scope: !67, inlinedAt: !65)
!73 = !DILocation(line: 15, column: 7, scope: !59, inlinedAt: !65)
!74 = !DILocation(line: 17, column: 23, scope: !75, inlinedAt: !65)
!75 = distinct !DILexicalBlock(scope: !67, file: !2, line: 16, column: 5)
!76 = !DILocation(line: 17, column: 12, scope: !75, inlinedAt: !65)
!77 = !{!78, !78, i64 0}
!78 = !{!"any pointer", !70, i64 0}
!79 = !DILocation(line: 18, column: 12, scope: !80, inlinedAt: !65)
!80 = distinct !DILexicalBlock(scope: !75, file: !2, line: 18, column: 11)
!81 = !DILocation(line: 18, column: 11, scope: !75, inlinedAt: !65)
!82 = !DILocation(line: 18, column: 18, scope: !80, inlinedAt: !65)
!83 = !DILocation(line: 23, column: 13, scope: !59, inlinedAt: !65)
!84 = !DILocation(line: 21, column: 10, scope: !59, inlinedAt: !65)
!85 = !DILocation(line: 22, column: 8, scope: !59, inlinedAt: !65)
!86 = !DILocation(line: 35, column: 49, scope: !49)
!87 = !DILocation(line: 0, scope: !59, inlinedAt: !88)
!88 = distinct !DILocation(line: 35, column: 33, scope: !49)
!89 = !DILocation(line: 15, column: 11, scope: !67, inlinedAt: !88)
!90 = !DILocation(line: 15, column: 7, scope: !59, inlinedAt: !88)
!91 = !DILocation(line: 17, column: 23, scope: !75, inlinedAt: !88)
!92 = !DILocation(line: 17, column: 12, scope: !75, inlinedAt: !88)
!93 = !DILocation(line: 18, column: 12, scope: !80, inlinedAt: !88)
!94 = !DILocation(line: 18, column: 11, scope: !75, inlinedAt: !88)
!95 = !DILocation(line: 18, column: 18, scope: !80, inlinedAt: !88)
!96 = !DILocation(line: 21, column: 10, scope: !59, inlinedAt: !88)
!97 = !DILocation(line: 23, column: 13, scope: !59, inlinedAt: !88)
!98 = !DILocation(line: 22, column: 8, scope: !59, inlinedAt: !88)
!99 = !DILocation(line: 35, column: 17, scope: !49)
!100 = !{!101, !78, i64 0}
!101 = !{!"hash", !78, i64 0, !78, i64 8, !69, i64 16}
!102 = !DILocation(line: 36, column: 14, scope: !103)
!103 = distinct !DILexicalBlock(scope: !104, file: !2, line: 36, column: 3)
!104 = distinct !DILexicalBlock(scope: !49, file: !2, line: 36, column: 3)
!105 = !DILocation(line: 36, column: 3, scope: !104)
!106 = !DILocation(line: 37, column: 13, scope: !103)
!107 = !DILocation(line: 37, column: 5, scope: !103)
!108 = !DILocation(line: 37, column: 21, scope: !103)
!109 = !DILocation(line: 36, column: 22, scope: !103)
!110 = distinct !{!110, !105, !111, !112}
!111 = !DILocation(line: 37, column: 22, scope: !104)
!112 = !{!"llvm.loop.mustprogress"}
!113 = distinct !{!113, !114}
!114 = !{!"llvm.loop.unroll.disable"}
!115 = !DILocation(line: 38, column: 11, scope: !49)
!116 = !DILocation(line: 38, column: 19, scope: !49)
!117 = !{!101, !78, i64 8}
!118 = !DILocation(line: 39, column: 11, scope: !49)
!119 = !DILocation(line: 39, column: 16, scope: !49)
!120 = !{!101, !69, i64 16}
!121 = !DILocation(line: 40, column: 3, scope: !49)
!122 = distinct !DISubprogram(name: "HashLookup", scope: !2, file: !2, line: 43, type: !123, scopeLine: 44, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !9, retainedNodes: !125)
!123 = !DISubroutineType(types: !124)
!124 = !{!25, !23, !11}
!125 = !{!126, !127, !128, !129}
!126 = !DILocalVariable(name: "key", arg: 1, scope: !122, file: !2, line: 43, type: !23)
!127 = !DILocalVariable(name: "hash", arg: 2, scope: !122, file: !2, line: 43, type: !11)
!128 = !DILocalVariable(name: "j", scope: !122, file: !2, line: 45, type: !31)
!129 = !DILocalVariable(name: "ent", scope: !122, file: !2, line: 46, type: !18)
!130 = !DILocation(line: 0, scope: !122)
!131 = !DILocation(line: 48, column: 14, scope: !122)
!132 = !DILocation(line: 48, column: 7, scope: !122)
!133 = !DILocation(line: 49, column: 3, scope: !134)
!134 = distinct !DILexicalBlock(scope: !122, file: !2, line: 49, column: 3)
!135 = !DILocation(line: 49, column: 3, scope: !122)
!136 = !DILocation(line: 49, column: 3, scope: !137)
!137 = distinct !DILexicalBlock(scope: !134, file: !2, line: 49, column: 3)
!138 = !DILocation(line: 50, column: 3, scope: !139)
!139 = distinct !DILexicalBlock(scope: !122, file: !2, line: 50, column: 3)
!140 = !DILocation(line: 50, column: 3, scope: !122)
!141 = !DILocation(line: 50, column: 3, scope: !142)
!142 = distinct !DILexicalBlock(scope: !139, file: !2, line: 50, column: 3)
!143 = !DILocation(line: 51, column: 20, scope: !144)
!144 = distinct !DILexicalBlock(scope: !122, file: !2, line: 51, column: 3)
!145 = !DILocation(line: 51, column: 14, scope: !144)
!146 = !DILocation(line: 0, scope: !144)
!147 = !DILocation(line: 52, column: 8, scope: !148)
!148 = distinct !DILexicalBlock(scope: !144, file: !2, line: 51, column: 3)
!149 = !DILocation(line: 52, column: 12, scope: !148)
!150 = !DILocation(line: 53, column: 17, scope: !148)
!151 = !{!152, !69, i64 0}
!152 = !{!"hash_entry", !69, i64 0, !78, i64 8, !78, i64 16}
!153 = !DILocation(line: 53, column: 20, scope: !148)
!154 = !DILocation(line: 51, column: 3, scope: !144)
!155 = !DILocation(line: 54, column: 17, scope: !148)
!156 = distinct !{!156, !154, !157, !112}
!157 = !DILocation(line: 54, column: 22, scope: !144)
!158 = !DILocation(line: 55, column: 24, scope: !159)
!159 = distinct !DILexicalBlock(scope: !122, file: !2, line: 55, column: 7)
!160 = !{!152, !78, i64 8}
!161 = !DILocation(line: 55, column: 12, scope: !159)
!162 = !DILocation(line: 57, column: 1, scope: !122)
!163 = !DISubprogram(name: "printf", scope: !164, file: !164, line: 356, type: !165, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !170)
!164 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "f31eefcc3f15835fc5a4023a625cf609")
!165 = !DISubroutineType(types: !166)
!166 = !{!31, !167, null}
!167 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !168)
!168 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !169, size: 64)
!169 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
!170 = !{}
!171 = !DISubprogram(name: "exit", scope: !172, file: !172, line: 624, type: !173, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized, retainedNodes: !170)
!172 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "02258fad21adf111bb9df9825e61954a")
!173 = !DISubroutineType(types: !174)
!174 = !{null, !31}
!175 = distinct !DISubprogram(name: "HashInsert", scope: !2, file: !2, line: 59, type: !176, scopeLine: 60, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !9, retainedNodes: !178)
!176 = !DISubroutineType(types: !177)
!177 = !{null, !25, !23, !11}
!178 = !{!179, !180, !181, !182, !183}
!179 = !DILocalVariable(name: "entry", arg: 1, scope: !175, file: !2, line: 59, type: !25)
!180 = !DILocalVariable(name: "key", arg: 2, scope: !175, file: !2, line: 59, type: !23)
!181 = !DILocalVariable(name: "hash", arg: 3, scope: !175, file: !2, line: 59, type: !11)
!182 = !DILocalVariable(name: "ent", scope: !175, file: !2, line: 61, type: !18)
!183 = !DILocalVariable(name: "j", scope: !175, file: !2, line: 62, type: !31)
!184 = !DILocation(line: 0, scope: !175)
!185 = !DILocation(line: 0, scope: !122, inlinedAt: !186)
!186 = distinct !DILocation(line: 64, column: 3, scope: !187)
!187 = distinct !DILexicalBlock(scope: !175, file: !2, line: 64, column: 3)
!188 = !DILocation(line: 48, column: 14, scope: !122, inlinedAt: !186)
!189 = !DILocation(line: 48, column: 7, scope: !122, inlinedAt: !186)
!190 = !DILocation(line: 49, column: 3, scope: !134, inlinedAt: !186)
!191 = !DILocation(line: 49, column: 3, scope: !122, inlinedAt: !186)
!192 = !DILocation(line: 49, column: 3, scope: !137, inlinedAt: !186)
!193 = !DILocation(line: 50, column: 3, scope: !139, inlinedAt: !186)
!194 = !DILocation(line: 50, column: 3, scope: !122, inlinedAt: !186)
!195 = !DILocation(line: 50, column: 3, scope: !142, inlinedAt: !186)
!196 = !DILocation(line: 51, column: 20, scope: !144, inlinedAt: !186)
!197 = !DILocation(line: 51, column: 14, scope: !144, inlinedAt: !186)
!198 = !DILocation(line: 0, scope: !144, inlinedAt: !186)
!199 = !DILocation(line: 52, column: 8, scope: !148, inlinedAt: !186)
!200 = !DILocation(line: 52, column: 12, scope: !148, inlinedAt: !186)
!201 = !DILocation(line: 53, column: 17, scope: !148, inlinedAt: !186)
!202 = !DILocation(line: 53, column: 20, scope: !148, inlinedAt: !186)
!203 = !DILocation(line: 51, column: 3, scope: !144, inlinedAt: !186)
!204 = !DILocation(line: 54, column: 17, scope: !148, inlinedAt: !186)
!205 = distinct !{!205, !203, !206, !112}
!206 = !DILocation(line: 54, column: 22, scope: !144, inlinedAt: !186)
!207 = !DILocation(line: 55, column: 24, scope: !159, inlinedAt: !186)
!208 = !DILocation(line: 64, column: 3, scope: !187)
!209 = !DILocation(line: 64, column: 3, scope: !175)
!210 = !DILocation(line: 64, column: 3, scope: !211)
!211 = distinct !DILexicalBlock(scope: !187, file: !2, line: 64, column: 3)
!212 = !DILocation(line: 66, column: 14, scope: !175)
!213 = !DILocation(line: 66, column: 7, scope: !175)
!214 = !DILocation(line: 0, scope: !59, inlinedAt: !215)
!215 = distinct !DILocation(line: 67, column: 21, scope: !175)
!216 = !DILocation(line: 15, column: 12, scope: !67, inlinedAt: !215)
!217 = !DILocation(line: 15, column: 11, scope: !67, inlinedAt: !215)
!218 = !DILocation(line: 15, column: 7, scope: !59, inlinedAt: !215)
!219 = !DILocation(line: 17, column: 23, scope: !75, inlinedAt: !215)
!220 = !DILocation(line: 17, column: 12, scope: !75, inlinedAt: !215)
!221 = !DILocation(line: 18, column: 12, scope: !80, inlinedAt: !215)
!222 = !DILocation(line: 18, column: 11, scope: !75, inlinedAt: !215)
!223 = !DILocation(line: 18, column: 18, scope: !80, inlinedAt: !215)
!224 = !DILocation(line: 23, column: 13, scope: !59, inlinedAt: !215)
!225 = !DILocation(line: 21, column: 10, scope: !59, inlinedAt: !215)
!226 = !DILocation(line: 22, column: 8, scope: !59, inlinedAt: !215)
!227 = !DILocation(line: 68, column: 21, scope: !175)
!228 = !DILocation(line: 68, column: 15, scope: !175)
!229 = !DILocation(line: 68, column: 8, scope: !175)
!230 = !DILocation(line: 68, column: 13, scope: !175)
!231 = !{!152, !78, i64 16}
!232 = !DILocation(line: 69, column: 17, scope: !175)
!233 = !DILocation(line: 70, column: 12, scope: !175)
!234 = !DILocation(line: 71, column: 8, scope: !175)
!235 = !DILocation(line: 71, column: 14, scope: !175)
!236 = !DILocation(line: 72, column: 1, scope: !175)
!237 = distinct !DISubprogram(name: "HashDelete", scope: !2, file: !2, line: 74, type: !238, scopeLine: 74, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !9, retainedNodes: !240)
!238 = !DISubroutineType(types: !239)
!239 = !{null, !23, !11}
!240 = !{!241, !242, !243, !244, !245}
!241 = !DILocalVariable(name: "key", arg: 1, scope: !237, file: !2, line: 74, type: !23)
!242 = !DILocalVariable(name: "hash", arg: 2, scope: !237, file: !2, line: 74, type: !11)
!243 = !DILocalVariable(name: "tmp", scope: !237, file: !2, line: 75, type: !18)
!244 = !DILocalVariable(name: "j", scope: !237, file: !2, line: 76, type: !31)
!245 = !DILocalVariable(name: "ent", scope: !237, file: !2, line: 77, type: !17)
!246 = !DILocation(line: 0, scope: !237)
!247 = !DILocation(line: 76, column: 18, scope: !237)
!248 = !DILocation(line: 76, column: 11, scope: !237)
!249 = !DILocation(line: 77, column: 27, scope: !237)
!250 = !DILocation(line: 77, column: 21, scope: !237)
!251 = !DILocation(line: 79, column: 10, scope: !237)
!252 = !DILocation(line: 79, column: 15, scope: !237)
!253 = !DILocation(line: 79, column: 26, scope: !237)
!254 = !DILocation(line: 79, column: 30, scope: !237)
!255 = !DILocation(line: 79, column: 3, scope: !237)
!256 = distinct !{!256, !255, !257, !112}
!257 = !DILocation(line: 81, column: 3, scope: !237)
!258 = !DILocation(line: 80, column: 20, scope: !259)
!259 = distinct !DILexicalBlock(scope: !237, file: !2, line: 79, column: 38)
!260 = !DILocation(line: 83, column: 3, scope: !261)
!261 = distinct !DILexicalBlock(scope: !262, file: !2, line: 83, column: 3)
!262 = distinct !DILexicalBlock(scope: !237, file: !2, line: 83, column: 3)
!263 = !DILocation(line: 86, column: 18, scope: !237)
!264 = !DILocation(line: 86, column: 8, scope: !237)
!265 = !DILocation(line: 88, column: 1, scope: !237)
!266 = !DISubprogram(name: "malloc", scope: !172, file: !172, line: 540, type: !267, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !170)
!267 = !DISubroutineType(types: !268)
!268 = !{!25, !269}
!269 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !270, line: 209, baseType: !271)
!270 = !DIFile(filename: "/usr/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "dbf961373c04bf7f9b2509c93f98f3a8")
!271 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
