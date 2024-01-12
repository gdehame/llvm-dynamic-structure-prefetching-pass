; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Village = type { [4 x ptr], ptr, %struct.List, %struct.Hosp, i32, i64 }
%struct.List = type { ptr, ptr, ptr }
%struct.Hosp = type { i32, i32, i32, %struct.List, %struct.List, %struct.List, %struct.List }
%struct.Patient = type { i32, i32, i32, ptr }

@.str = private unnamed_addr constant [37 x i8] c"max_level=%d  max_time=%d  seed=%d \0A\00", align 1
@seed = dso_local local_unnamed_addr global i64 0, align 8
@max_level = dso_local local_unnamed_addr global i32 0, align 4
@max_time = dso_local local_unnamed_addr global i64 0, align 8
@.str.2 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.5 = private unnamed_addr constant [45 x i8] c"# of people treated:              %f people\0A\00", align 1
@.str.6 = private unnamed_addr constant [52 x i8] c"Average length of stay:           %0.2f time units\0A\00", align 1
@.str.7 = private unnamed_addr constant [49 x i8] c"Average # of hospitals visited:   %f hospitals\0A\0A\00", align 1
@str = private unnamed_addr constant [39 x i8] c"\0A\0A    Columbian Health Care Simulator\0A\00", align 1
@str.8 = private unnamed_addr constant [11 x i8] c"Working...\00", align 1
@str.9 = private unnamed_addr constant [16 x i8] c"Getting Results\00", align 1
@str.10 = private unnamed_addr constant [7 x i8] c"Done.\0A\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local void @dealwithargs(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = icmp slt i32 %0, 4
  br i1 %3, label %4, label %5

4:                                                ; preds = %2
  store i32 3, ptr @max_level, align 4, !tbaa !5
  store i64 15, ptr @max_time, align 8, !tbaa !9
  br label %19

5:                                                ; preds = %2
  %6 = getelementptr inbounds ptr, ptr %1, i64 1
  %7 = load ptr, ptr %6, align 8, !tbaa !11
  %8 = tail call i64 @strtol(ptr nocapture noundef nonnull %7, ptr noundef null, i32 noundef 10) #12
  %9 = trunc i64 %8 to i32
  store i32 %9, ptr @max_level, align 4, !tbaa !5
  %10 = getelementptr inbounds ptr, ptr %1, i64 2
  %11 = load ptr, ptr %10, align 8, !tbaa !11
  %12 = tail call i64 @strtol(ptr nocapture noundef nonnull %11, ptr noundef null, i32 noundef 10) #12
  store i64 %12, ptr @max_time, align 8, !tbaa !9
  %13 = getelementptr inbounds ptr, ptr %1, i64 3
  %14 = load ptr, ptr %13, align 8, !tbaa !11
  %15 = tail call i64 @strtol(ptr nocapture noundef nonnull %14, ptr noundef null, i32 noundef 10) #12
  %16 = load i32, ptr @max_level, align 4, !tbaa !5
  %17 = load i64, ptr @max_time, align 8, !tbaa !9
  %18 = trunc i64 %17 to i32
  br label %19

19:                                               ; preds = %5, %4
  %20 = phi i32 [ %18, %5 ], [ 15, %4 ]
  %21 = phi i32 [ %16, %5 ], [ 3, %4 ]
  %22 = phi i64 [ %15, %5 ], [ 4, %4 ]
  store i64 %22, ptr @seed, align 8, !tbaa !13
  %23 = trunc i64 %22 to i32
  %24 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %21, i32 noundef %20, i32 noundef %23)
  ret void
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: nofree nounwind uwtable
define dso_local ptr @alloc_tree(i32 noundef %0, i32 noundef %1, ptr noundef %2) local_unnamed_addr #0 {
  %4 = icmp eq i32 %0, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %7, %3
  %6 = phi ptr [ %8, %7 ], [ null, %3 ]
  ret ptr %6

7:                                                ; preds = %3
  %8 = tail call noalias dereferenceable_or_null(192) ptr @malloc(i64 noundef 192) #13
  %9 = add nsw i32 %0, -1
  %10 = shl nsw i32 %1, 2
  %11 = or i32 %10, 1
  %12 = add i32 %10, 4
  %13 = tail call ptr @alloc_tree(i32 noundef %9, i32 noundef %12, ptr noundef %8)
  %14 = or i32 %10, 3
  %15 = tail call ptr @alloc_tree(i32 noundef %9, i32 noundef %14, ptr noundef %8)
  %16 = or i32 %10, 2
  %17 = tail call ptr @alloc_tree(i32 noundef %9, i32 noundef %16, ptr noundef %8)
  %18 = tail call ptr @alloc_tree(i32 noundef %9, i32 noundef %11, ptr noundef %8)
  %19 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 1
  store ptr %2, ptr %19, align 8, !tbaa !15
  %20 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 4
  store i32 %1, ptr %20, align 8, !tbaa !19
  %21 = sext i32 %1 to i64
  %22 = load i64, ptr @seed, align 8, !tbaa !13
  %23 = add nsw i64 %22, 127773
  %24 = mul nsw i64 %23, %21
  %25 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 5
  store i64 %24, ptr %25, align 8, !tbaa !20
  %26 = tail call double @ldexp(double 1.000000e+00, i32 %9) #12
  %27 = fptosi double %26 to i32
  %28 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 3
  store i32 %27, ptr %28, align 8, !tbaa !21
  %29 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 3, i32 1
  store i32 %27, ptr %29, align 4, !tbaa !22
  %30 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 3, i32 2
  store i32 0, ptr %30, align 8, !tbaa !23
  %31 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 3, i32 3
  %32 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 2
  %33 = getelementptr inbounds %struct.Village, ptr %8, i64 0, i32 2, i32 2
  store ptr null, ptr %33, align 8, !tbaa !24
  store ptr null, ptr %32, align 8, !tbaa !25
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %31, i8 0, i64 96, i1 false)
  store ptr %18, ptr %8, align 8, !tbaa !11
  %34 = getelementptr inbounds i8, ptr %8, i64 8
  store ptr %17, ptr %34, align 8, !tbaa !11
  %35 = getelementptr inbounds i8, ptr %8, i64 16
  store ptr %15, ptr %35, align 8, !tbaa !11
  %36 = getelementptr inbounds i8, ptr %8, i64 24
  store ptr %13, ptr %36, align 8, !tbaa !11
  br label %5
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #3

; Function Attrs: nofree willreturn
declare double @ldexp(double, i32) local_unnamed_addr #4

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nofree nosync nounwind memory(read, inaccessiblemem: none) uwtable
define dso_local { <2 x float>, float } @get_results(ptr noundef readonly %0) local_unnamed_addr #6 {
  %2 = icmp eq ptr %0, null
  br i1 %2, label %50, label %3

3:                                                ; preds = %1
  %4 = getelementptr inbounds [4 x ptr], ptr %0, i64 0, i64 3
  %5 = load ptr, ptr %4, align 8, !tbaa !11
  %6 = tail call { <2 x float>, float } @get_results(ptr noundef %5)
  %7 = extractvalue { <2 x float>, float } %6, 0
  %8 = extractvalue { <2 x float>, float } %6, 1
  %9 = getelementptr inbounds [4 x ptr], ptr %0, i64 0, i64 2
  %10 = load ptr, ptr %9, align 8, !tbaa !11
  %11 = tail call { <2 x float>, float } @get_results(ptr noundef %10)
  %12 = extractvalue { <2 x float>, float } %11, 0
  %13 = extractvalue { <2 x float>, float } %11, 1
  %14 = getelementptr inbounds [4 x ptr], ptr %0, i64 0, i64 1
  %15 = load ptr, ptr %14, align 8, !tbaa !11
  %16 = tail call { <2 x float>, float } @get_results(ptr noundef %15)
  %17 = extractvalue { <2 x float>, float } %16, 0
  %18 = extractvalue { <2 x float>, float } %16, 1
  %19 = load ptr, ptr %0, align 8, !tbaa !11
  %20 = tail call { <2 x float>, float } @get_results(ptr noundef %19)
  %21 = extractvalue { <2 x float>, float } %20, 0
  %22 = extractvalue { <2 x float>, float } %20, 1
  %23 = fadd float %8, 0.000000e+00
  %24 = fadd float %23, %13
  %25 = fadd float %24, %18
  %26 = fadd float %25, %22
  %27 = fadd <2 x float> %7, zeroinitializer
  %28 = fadd <2 x float> %27, %12
  %29 = fadd <2 x float> %28, %17
  %30 = fadd <2 x float> %29, %21
  %31 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 2
  %32 = load ptr, ptr %31, align 8, !tbaa !26
  %33 = icmp eq ptr %32, null
  br i1 %33, label %50, label %34

34:                                               ; preds = %34, %3
  %35 = phi ptr [ %48, %34 ], [ %32, %3 ]
  %36 = phi float [ %42, %34 ], [ %26, %3 ]
  %37 = phi <2 x float> [ %47, %34 ], [ %30, %3 ]
  %38 = getelementptr inbounds %struct.List, ptr %35, i64 0, i32 1
  %39 = load ptr, ptr %38, align 8, !tbaa !27
  %40 = load i32, ptr %39, align 8, !tbaa !28
  %41 = sitofp i32 %40 to float
  %42 = fadd float %36, %41
  %43 = getelementptr inbounds %struct.Patient, ptr %39, i64 0, i32 1
  %44 = load i32, ptr %43, align 4, !tbaa !30
  %45 = sitofp i32 %44 to float
  %46 = insertelement <2 x float> <float 1.000000e+00, float poison>, float %45, i64 1
  %47 = fadd <2 x float> %37, %46
  %48 = load ptr, ptr %35, align 8, !tbaa !26
  %49 = icmp eq ptr %48, null
  br i1 %49, label %50, label %34, !llvm.loop !31

50:                                               ; preds = %34, %3, %1
  %51 = phi <2 x float> [ zeroinitializer, %1 ], [ %30, %3 ], [ %47, %34 ]
  %52 = phi float [ 0.000000e+00, %1 ], [ %26, %3 ], [ %42, %34 ]
  %53 = insertvalue { <2 x float>, float } poison, <2 x float> %51, 0
  %54 = insertvalue { <2 x float>, float } %53, float %52, 1
  ret { <2 x float>, float } %54
}

; Function Attrs: nounwind uwtable
define dso_local void @check_patients_inside(ptr noundef %0, ptr noundef readonly %1) local_unnamed_addr #7 {
  %3 = icmp eq ptr %1, null
  br i1 %3, label %22, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 1
  %6 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5
  %7 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 2
  br label %8

8:                                                ; preds = %19, %4
  %9 = phi ptr [ %1, %4 ], [ %20, %19 ]
  %10 = getelementptr inbounds %struct.List, ptr %9, i64 0, i32 1
  %11 = load ptr, ptr %10, align 8, !tbaa !27
  %12 = getelementptr inbounds %struct.Patient, ptr %11, i64 0, i32 2
  %13 = load i32, ptr %12, align 8, !tbaa !33
  %14 = add nsw i32 %13, -1
  store i32 %14, ptr %12, align 8, !tbaa !33
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %16, label %19

16:                                               ; preds = %8
  %17 = load i32, ptr %5, align 4, !tbaa !22
  %18 = add nsw i32 %17, 1
  store i32 %18, ptr %5, align 4, !tbaa !22
  tail call void @removeList(ptr noundef nonnull %6, ptr noundef nonnull %11) #12
  tail call void @addList(ptr noundef nonnull %7, ptr noundef nonnull %11) #12
  br label %19

19:                                               ; preds = %16, %8
  %20 = load ptr, ptr %9, align 8, !tbaa !26
  %21 = icmp eq ptr %20, null
  br i1 %21, label %22, label %8, !llvm.loop !34

22:                                               ; preds = %19, %2
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local ptr @check_patients_assess(ptr noundef %0, ptr noundef readonly %1) local_unnamed_addr #7 {
  %3 = icmp eq ptr %1, null
  br i1 %3, label %41, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 4
  %6 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 5
  %7 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 1
  %8 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 4
  %9 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 6
  %10 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5
  br label %11

11:                                               ; preds = %37, %4
  %12 = phi ptr [ %1, %4 ], [ %39, %37 ]
  %13 = phi ptr [ null, %4 ], [ %38, %37 ]
  %14 = getelementptr inbounds %struct.List, ptr %12, i64 0, i32 1
  %15 = load ptr, ptr %14, align 8, !tbaa !27
  %16 = getelementptr inbounds %struct.Patient, ptr %15, i64 0, i32 2
  %17 = load i32, ptr %16, align 8, !tbaa !33
  %18 = add nsw i32 %17, -1
  store i32 %18, ptr %16, align 8, !tbaa !33
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %37

20:                                               ; preds = %11
  %21 = load i64, ptr %6, align 8, !tbaa !20
  %22 = tail call float @my_rand(i64 noundef %21) #12
  %23 = fmul float %22, 0x41E0000000000000
  %24 = fptosi float %23 to i64
  store i64 %24, ptr %6, align 8, !tbaa !20
  %25 = load i32, ptr %5, align 8, !tbaa !19
  %26 = fpext float %22 to double
  %27 = fcmp ogt double %26, 1.000000e-01
  %28 = icmp eq i32 %25, 0
  %29 = select i1 %27, i1 true, i1 %28
  br i1 %29, label %30, label %34

30:                                               ; preds = %20
  tail call void @removeList(ptr noundef nonnull %8, ptr noundef nonnull %15) #12
  tail call void @addList(ptr noundef nonnull %10, ptr noundef nonnull %15) #12
  store i32 10, ptr %16, align 8, !tbaa !33
  %31 = getelementptr inbounds %struct.Patient, ptr %15, i64 0, i32 1
  %32 = load i32, ptr %31, align 4, !tbaa !30
  %33 = add nsw i32 %32, 10
  store i32 %33, ptr %31, align 4, !tbaa !30
  br label %37

34:                                               ; preds = %20
  %35 = load i32, ptr %7, align 4, !tbaa !22
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %7, align 4, !tbaa !22
  tail call void @removeList(ptr noundef nonnull %8, ptr noundef nonnull %15) #12
  tail call void @addList(ptr noundef nonnull %9, ptr noundef nonnull %15) #12
  br label %37

37:                                               ; preds = %34, %30, %11
  %38 = phi ptr [ %13, %30 ], [ %9, %34 ], [ %13, %11 ]
  %39 = load ptr, ptr %12, align 8, !tbaa !26
  %40 = icmp eq ptr %39, null
  br i1 %40, label %41, label %11, !llvm.loop !35

41:                                               ; preds = %37, %2
  %42 = phi ptr [ null, %2 ], [ %38, %37 ]
  ret ptr %42
}

; Function Attrs: nounwind uwtable
define dso_local void @check_patients_waiting(ptr noundef %0, ptr noundef readonly %1) local_unnamed_addr #7 {
  %3 = icmp eq ptr %1, null
  br i1 %3, label %40, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 1
  %6 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 3
  %7 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 4
  %8 = load i32, ptr %5, align 4, !tbaa !22
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %21, label %10

10:                                               ; preds = %10, %4
  %11 = phi ptr [ %17, %10 ], [ %1, %4 ]
  %12 = getelementptr inbounds %struct.List, ptr %11, i64 0, i32 1
  %13 = load ptr, ptr %12, align 8, !tbaa !27
  %14 = getelementptr inbounds %struct.Patient, ptr %13, i64 0, i32 1
  %15 = load i32, ptr %14, align 4, !tbaa !30
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %14, align 4, !tbaa !30
  %17 = load ptr, ptr %11, align 8, !tbaa !26
  %18 = icmp eq ptr %17, null
  br i1 %18, label %40, label %10, !llvm.loop !36

19:                                               ; preds = %37
  %20 = load i32, ptr %5, align 4, !tbaa !22
  br label %21

21:                                               ; preds = %19, %4
  %22 = phi i32 [ %20, %19 ], [ %8, %4 ]
  %23 = phi ptr [ %38, %19 ], [ %1, %4 ]
  %24 = getelementptr inbounds %struct.List, ptr %23, i64 0, i32 1
  %25 = load ptr, ptr %24, align 8, !tbaa !27
  %26 = icmp sgt i32 %22, 0
  br i1 %26, label %27, label %33

27:                                               ; preds = %21
  %28 = add nsw i32 %22, -1
  store i32 %28, ptr %5, align 4, !tbaa !22
  %29 = getelementptr inbounds %struct.Patient, ptr %25, i64 0, i32 2
  store i32 3, ptr %29, align 8, !tbaa !33
  %30 = getelementptr inbounds %struct.Patient, ptr %25, i64 0, i32 1
  %31 = load i32, ptr %30, align 4, !tbaa !30
  %32 = add nsw i32 %31, 3
  store i32 %32, ptr %30, align 4, !tbaa !30
  tail call void @removeList(ptr noundef nonnull %6, ptr noundef %25) #12
  tail call void @addList(ptr noundef nonnull %7, ptr noundef %25) #12
  br label %37

33:                                               ; preds = %21
  %34 = getelementptr inbounds %struct.Patient, ptr %25, i64 0, i32 1
  %35 = load i32, ptr %34, align 4, !tbaa !30
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %34, align 4, !tbaa !30
  br label %37

37:                                               ; preds = %33, %27
  %38 = load ptr, ptr %23, align 8, !tbaa !26
  %39 = icmp eq ptr %38, null
  br i1 %39, label %40, label %19, !llvm.loop !37

40:                                               ; preds = %37, %10, %2
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @put_in_hosp(ptr noundef %0, ptr noundef %1) local_unnamed_addr #7 {
  %3 = load i32, ptr %1, align 8, !tbaa !28
  %4 = add nsw i32 %3, 1
  store i32 %4, ptr %1, align 8, !tbaa !28
  %5 = getelementptr inbounds %struct.Hosp, ptr %0, i64 0, i32 1
  %6 = load i32, ptr %5, align 4, !tbaa !39
  %7 = icmp sgt i32 %6, 0
  br i1 %7, label %8, label %15

8:                                                ; preds = %2
  %9 = add nsw i32 %6, -1
  store i32 %9, ptr %5, align 4, !tbaa !39
  %10 = getelementptr inbounds %struct.Hosp, ptr %0, i64 0, i32 4
  tail call void @addList(ptr noundef nonnull %10, ptr noundef nonnull %1) #12
  %11 = getelementptr inbounds %struct.Patient, ptr %1, i64 0, i32 2
  store i32 3, ptr %11, align 8, !tbaa !33
  %12 = getelementptr inbounds %struct.Patient, ptr %1, i64 0, i32 1
  %13 = load i32, ptr %12, align 4, !tbaa !30
  %14 = add nsw i32 %13, 3
  store i32 %14, ptr %12, align 4, !tbaa !30
  br label %17

15:                                               ; preds = %2
  %16 = getelementptr inbounds %struct.Hosp, ptr %0, i64 0, i32 3
  tail call void @addList(ptr noundef nonnull %16, ptr noundef nonnull %1) #12
  br label %17

17:                                               ; preds = %15, %8
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local noalias ptr @generate_patient(ptr noundef %0) local_unnamed_addr #7 {
  %2 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 5
  %3 = load i64, ptr %2, align 8, !tbaa !20
  %4 = tail call float @my_rand(i64 noundef %3) #12
  %5 = fmul float %4, 0x41E0000000000000
  %6 = fptosi float %5 to i64
  store i64 %6, ptr %2, align 8, !tbaa !20
  %7 = fpext float %4 to double
  %8 = fcmp ogt double %7, 6.660000e-01
  br i1 %8, label %9, label %14

9:                                                ; preds = %1
  %10 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #13
  store i32 0, ptr %10, align 8, !tbaa !28
  %11 = getelementptr inbounds %struct.Patient, ptr %10, i64 0, i32 1
  store i32 0, ptr %11, align 4, !tbaa !30
  %12 = getelementptr inbounds %struct.Patient, ptr %10, i64 0, i32 2
  store i32 0, ptr %12, align 8, !tbaa !33
  %13 = getelementptr inbounds %struct.Patient, ptr %10, i64 0, i32 3
  store ptr %0, ptr %13, align 8, !tbaa !40
  br label %14

14:                                               ; preds = %9, %1
  %15 = phi ptr [ %10, %9 ], [ null, %1 ]
  ret ptr %15
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) local_unnamed_addr #8 {
  tail call void @dealwithargs(i32 noundef %0, ptr noundef %1) #12
  %3 = load i32, ptr @max_level, align 4, !tbaa !5
  %4 = tail call ptr @alloc_tree(i32 noundef %3, i32 noundef 0, ptr noundef null)
  %5 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  %6 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.8)
  %7 = load i64, ptr @max_time, align 8, !tbaa !9
  %8 = icmp sgt i64 %7, 0
  br i1 %8, label %9, label %21

9:                                                ; preds = %16, %2
  %10 = phi i64 [ %18, %16 ], [ 0, %2 ]
  %11 = trunc i64 %10 to i32
  %12 = urem i32 %11, 50
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %16

14:                                               ; preds = %9
  %15 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef %11)
  br label %16

16:                                               ; preds = %14, %9
  %17 = tail call ptr @sim(ptr noundef %4)
  %18 = add nuw nsw i64 %10, 1
  %19 = load i64, ptr @max_time, align 8, !tbaa !9
  %20 = icmp sgt i64 %19, %18
  br i1 %20, label %9, label %21, !llvm.loop !41

21:                                               ; preds = %16, %2
  %22 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  %23 = tail call { <2 x float>, float } @get_results(ptr noundef %4)
  %24 = extractvalue { <2 x float>, float } %23, 0
  %25 = extractvalue { <2 x float>, float } %23, 1
  %26 = extractelement <2 x float> %24, i64 0
  %27 = extractelement <2 x float> %24, i64 1
  %28 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  %29 = fpext float %26 to double
  %30 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef %29)
  %31 = fdiv float %27, %26
  %32 = fpext float %31 to double
  %33 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef %32)
  %34 = fdiv float %25, %26
  %35 = fpext float %34 to double
  %36 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef %35)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local ptr @sim(ptr noundef %0) local_unnamed_addr #7 {
  %2 = icmp eq ptr %0, null
  br i1 %2, label %191, label %3

3:                                                ; preds = %1
  %4 = getelementptr inbounds [4 x ptr], ptr %0, i64 0, i64 3
  %5 = load ptr, ptr %4, align 8, !tbaa !11
  %6 = tail call ptr @sim(ptr noundef %5)
  %7 = getelementptr inbounds [4 x ptr], ptr %0, i64 0, i64 2
  %8 = load ptr, ptr %7, align 8, !tbaa !11
  %9 = tail call ptr @sim(ptr noundef %8)
  %10 = getelementptr inbounds [4 x ptr], ptr %0, i64 0, i64 1
  %11 = load ptr, ptr %10, align 8, !tbaa !11
  %12 = tail call ptr @sim(ptr noundef %11)
  %13 = load ptr, ptr %0, align 8, !tbaa !11
  %14 = tail call ptr @sim(ptr noundef %13)
  %15 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 1
  %16 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 3
  %17 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 4
  %18 = icmp eq ptr %6, null
  br i1 %18, label %41, label %19

19:                                               ; preds = %3
  %20 = load ptr, ptr %6, align 8, !tbaa !26
  %21 = icmp eq ptr %20, null
  br i1 %21, label %41, label %22

22:                                               ; preds = %37, %19
  %23 = phi ptr [ %39, %37 ], [ %20, %19 ]
  %24 = getelementptr inbounds %struct.List, ptr %23, i64 0, i32 1
  %25 = load ptr, ptr %24, align 8, !tbaa !27
  %26 = load i32, ptr %25, align 8, !tbaa !28
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %25, align 8, !tbaa !28
  %28 = load i32, ptr %15, align 4, !tbaa !39
  %29 = icmp sgt i32 %28, 0
  br i1 %29, label %30, label %36

30:                                               ; preds = %22
  %31 = add nsw i32 %28, -1
  store i32 %31, ptr %15, align 4, !tbaa !39
  tail call void @addList(ptr noundef nonnull %17, ptr noundef nonnull %25) #12
  %32 = getelementptr inbounds %struct.Patient, ptr %25, i64 0, i32 2
  store i32 3, ptr %32, align 8, !tbaa !33
  %33 = getelementptr inbounds %struct.Patient, ptr %25, i64 0, i32 1
  %34 = load i32, ptr %33, align 4, !tbaa !30
  %35 = add nsw i32 %34, 3
  store i32 %35, ptr %33, align 4, !tbaa !30
  br label %37

36:                                               ; preds = %22
  tail call void @addList(ptr noundef nonnull %16, ptr noundef nonnull %25) #12
  br label %37

37:                                               ; preds = %36, %30
  %38 = load ptr, ptr %24, align 8, !tbaa !27
  tail call void @removeList(ptr noundef nonnull %6, ptr noundef %38) #12
  %39 = load ptr, ptr %23, align 8, !tbaa !26
  %40 = icmp eq ptr %39, null
  br i1 %40, label %41, label %22, !llvm.loop !42

41:                                               ; preds = %37, %19, %3
  %42 = icmp eq ptr %9, null
  br i1 %42, label %65, label %43

43:                                               ; preds = %41
  %44 = load ptr, ptr %9, align 8, !tbaa !26
  %45 = icmp eq ptr %44, null
  br i1 %45, label %65, label %46

46:                                               ; preds = %61, %43
  %47 = phi ptr [ %63, %61 ], [ %44, %43 ]
  %48 = getelementptr inbounds %struct.List, ptr %47, i64 0, i32 1
  %49 = load ptr, ptr %48, align 8, !tbaa !27
  %50 = load i32, ptr %49, align 8, !tbaa !28
  %51 = add nsw i32 %50, 1
  store i32 %51, ptr %49, align 8, !tbaa !28
  %52 = load i32, ptr %15, align 4, !tbaa !39
  %53 = icmp sgt i32 %52, 0
  br i1 %53, label %55, label %54

54:                                               ; preds = %46
  tail call void @addList(ptr noundef nonnull %16, ptr noundef nonnull %49) #12
  br label %61

55:                                               ; preds = %46
  %56 = add nsw i32 %52, -1
  store i32 %56, ptr %15, align 4, !tbaa !39
  tail call void @addList(ptr noundef nonnull %17, ptr noundef nonnull %49) #12
  %57 = getelementptr inbounds %struct.Patient, ptr %49, i64 0, i32 2
  store i32 3, ptr %57, align 8, !tbaa !33
  %58 = getelementptr inbounds %struct.Patient, ptr %49, i64 0, i32 1
  %59 = load i32, ptr %58, align 4, !tbaa !30
  %60 = add nsw i32 %59, 3
  store i32 %60, ptr %58, align 4, !tbaa !30
  br label %61

61:                                               ; preds = %55, %54
  %62 = load ptr, ptr %48, align 8, !tbaa !27
  tail call void @removeList(ptr noundef nonnull %9, ptr noundef %62) #12
  %63 = load ptr, ptr %47, align 8, !tbaa !26
  %64 = icmp eq ptr %63, null
  br i1 %64, label %65, label %46, !llvm.loop !42

65:                                               ; preds = %61, %43, %41
  %66 = icmp eq ptr %12, null
  br i1 %66, label %89, label %67

67:                                               ; preds = %65
  %68 = load ptr, ptr %12, align 8, !tbaa !26
  %69 = icmp eq ptr %68, null
  br i1 %69, label %89, label %70

70:                                               ; preds = %85, %67
  %71 = phi ptr [ %87, %85 ], [ %68, %67 ]
  %72 = getelementptr inbounds %struct.List, ptr %71, i64 0, i32 1
  %73 = load ptr, ptr %72, align 8, !tbaa !27
  %74 = load i32, ptr %73, align 8, !tbaa !28
  %75 = add nsw i32 %74, 1
  store i32 %75, ptr %73, align 8, !tbaa !28
  %76 = load i32, ptr %15, align 4, !tbaa !39
  %77 = icmp sgt i32 %76, 0
  br i1 %77, label %79, label %78

78:                                               ; preds = %70
  tail call void @addList(ptr noundef nonnull %16, ptr noundef nonnull %73) #12
  br label %85

79:                                               ; preds = %70
  %80 = add nsw i32 %76, -1
  store i32 %80, ptr %15, align 4, !tbaa !39
  tail call void @addList(ptr noundef nonnull %17, ptr noundef nonnull %73) #12
  %81 = getelementptr inbounds %struct.Patient, ptr %73, i64 0, i32 2
  store i32 3, ptr %81, align 8, !tbaa !33
  %82 = getelementptr inbounds %struct.Patient, ptr %73, i64 0, i32 1
  %83 = load i32, ptr %82, align 4, !tbaa !30
  %84 = add nsw i32 %83, 3
  store i32 %84, ptr %82, align 4, !tbaa !30
  br label %85

85:                                               ; preds = %79, %78
  %86 = load ptr, ptr %72, align 8, !tbaa !27
  tail call void @removeList(ptr noundef nonnull %12, ptr noundef %86) #12
  %87 = load ptr, ptr %71, align 8, !tbaa !26
  %88 = icmp eq ptr %87, null
  br i1 %88, label %89, label %70, !llvm.loop !42

89:                                               ; preds = %85, %67, %65
  %90 = icmp eq ptr %14, null
  br i1 %90, label %113, label %91

91:                                               ; preds = %89
  %92 = load ptr, ptr %14, align 8, !tbaa !26
  %93 = icmp eq ptr %92, null
  br i1 %93, label %113, label %94

94:                                               ; preds = %109, %91
  %95 = phi ptr [ %111, %109 ], [ %92, %91 ]
  %96 = getelementptr inbounds %struct.List, ptr %95, i64 0, i32 1
  %97 = load ptr, ptr %96, align 8, !tbaa !27
  %98 = load i32, ptr %97, align 8, !tbaa !28
  %99 = add nsw i32 %98, 1
  store i32 %99, ptr %97, align 8, !tbaa !28
  %100 = load i32, ptr %15, align 4, !tbaa !39
  %101 = icmp sgt i32 %100, 0
  br i1 %101, label %103, label %102

102:                                              ; preds = %94
  tail call void @addList(ptr noundef nonnull %16, ptr noundef nonnull %97) #12
  br label %109

103:                                              ; preds = %94
  %104 = add nsw i32 %100, -1
  store i32 %104, ptr %15, align 4, !tbaa !39
  tail call void @addList(ptr noundef nonnull %17, ptr noundef nonnull %97) #12
  %105 = getelementptr inbounds %struct.Patient, ptr %97, i64 0, i32 2
  store i32 3, ptr %105, align 8, !tbaa !33
  %106 = getelementptr inbounds %struct.Patient, ptr %97, i64 0, i32 1
  %107 = load i32, ptr %106, align 4, !tbaa !30
  %108 = add nsw i32 %107, 3
  store i32 %108, ptr %106, align 4, !tbaa !30
  br label %109

109:                                              ; preds = %103, %102
  %110 = load ptr, ptr %96, align 8, !tbaa !27
  tail call void @removeList(ptr noundef nonnull %14, ptr noundef %110) #12
  %111 = load ptr, ptr %95, align 8, !tbaa !26
  %112 = icmp eq ptr %111, null
  br i1 %112, label %113, label %94, !llvm.loop !42

113:                                              ; preds = %109, %91, %89
  %114 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5
  %115 = load ptr, ptr %114, align 8, !tbaa !43
  %116 = icmp eq ptr %115, null
  br i1 %116, label %133, label %117

117:                                              ; preds = %113
  %118 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 2
  br label %119

119:                                              ; preds = %130, %117
  %120 = phi ptr [ %115, %117 ], [ %131, %130 ]
  %121 = getelementptr inbounds %struct.List, ptr %120, i64 0, i32 1
  %122 = load ptr, ptr %121, align 8, !tbaa !27
  %123 = getelementptr inbounds %struct.Patient, ptr %122, i64 0, i32 2
  %124 = load i32, ptr %123, align 8, !tbaa !33
  %125 = add nsw i32 %124, -1
  store i32 %125, ptr %123, align 8, !tbaa !33
  %126 = icmp eq i32 %125, 0
  br i1 %126, label %127, label %130

127:                                              ; preds = %119
  %128 = load i32, ptr %15, align 4, !tbaa !22
  %129 = add nsw i32 %128, 1
  store i32 %129, ptr %15, align 4, !tbaa !22
  tail call void @removeList(ptr noundef nonnull %114, ptr noundef nonnull %122) #12
  tail call void @addList(ptr noundef nonnull %118, ptr noundef nonnull %122) #12
  br label %130

130:                                              ; preds = %127, %119
  %131 = load ptr, ptr %120, align 8, !tbaa !26
  %132 = icmp eq ptr %131, null
  br i1 %132, label %133, label %119, !llvm.loop !34

133:                                              ; preds = %130, %113
  %134 = load ptr, ptr %17, align 8, !tbaa !44
  %135 = tail call ptr @check_patients_assess(ptr noundef nonnull %0, ptr noundef %134)
  %136 = load ptr, ptr %16, align 8, !tbaa !45
  %137 = icmp eq ptr %136, null
  br i1 %137, label %171, label %138

138:                                              ; preds = %133
  %139 = load i32, ptr %15, align 4, !tbaa !22
  %140 = icmp sgt i32 %139, 0
  br i1 %140, label %152, label %141

141:                                              ; preds = %141, %138
  %142 = phi ptr [ %148, %141 ], [ %136, %138 ]
  %143 = getelementptr inbounds %struct.List, ptr %142, i64 0, i32 1
  %144 = load ptr, ptr %143, align 8, !tbaa !27
  %145 = getelementptr inbounds %struct.Patient, ptr %144, i64 0, i32 1
  %146 = load i32, ptr %145, align 4, !tbaa !30
  %147 = add nsw i32 %146, 1
  store i32 %147, ptr %145, align 4, !tbaa !30
  %148 = load ptr, ptr %142, align 8, !tbaa !26
  %149 = icmp eq ptr %148, null
  br i1 %149, label %171, label %141, !llvm.loop !36

150:                                              ; preds = %168
  %151 = load i32, ptr %15, align 4, !tbaa !22
  br label %152

152:                                              ; preds = %150, %138
  %153 = phi i32 [ %151, %150 ], [ %139, %138 ]
  %154 = phi ptr [ %169, %150 ], [ %136, %138 ]
  %155 = getelementptr inbounds %struct.List, ptr %154, i64 0, i32 1
  %156 = load ptr, ptr %155, align 8, !tbaa !27
  %157 = icmp sgt i32 %153, 0
  br i1 %157, label %158, label %164

158:                                              ; preds = %152
  %159 = add nsw i32 %153, -1
  store i32 %159, ptr %15, align 4, !tbaa !22
  %160 = getelementptr inbounds %struct.Patient, ptr %156, i64 0, i32 2
  store i32 3, ptr %160, align 8, !tbaa !33
  %161 = getelementptr inbounds %struct.Patient, ptr %156, i64 0, i32 1
  %162 = load i32, ptr %161, align 4, !tbaa !30
  %163 = add nsw i32 %162, 3
  store i32 %163, ptr %161, align 4, !tbaa !30
  tail call void @removeList(ptr noundef nonnull %16, ptr noundef %156) #12
  tail call void @addList(ptr noundef nonnull %17, ptr noundef %156) #12
  br label %168

164:                                              ; preds = %152
  %165 = getelementptr inbounds %struct.Patient, ptr %156, i64 0, i32 1
  %166 = load i32, ptr %165, align 4, !tbaa !30
  %167 = add nsw i32 %166, 1
  store i32 %167, ptr %165, align 4, !tbaa !30
  br label %168

168:                                              ; preds = %164, %158
  %169 = load ptr, ptr %154, align 8, !tbaa !26
  %170 = icmp eq ptr %169, null
  br i1 %170, label %171, label %150, !llvm.loop !37

171:                                              ; preds = %168, %141, %133
  %172 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 5
  %173 = load i64, ptr %172, align 8, !tbaa !20
  %174 = tail call float @my_rand(i64 noundef %173) #12
  %175 = fmul float %174, 0x41E0000000000000
  %176 = fptosi float %175 to i64
  store i64 %176, ptr %172, align 8, !tbaa !20
  %177 = fpext float %174 to double
  %178 = fcmp ogt double %177, 6.660000e-01
  br i1 %178, label %179, label %191

179:                                              ; preds = %171
  %180 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #13
  %181 = getelementptr inbounds %struct.Patient, ptr %180, i64 0, i32 1
  store i32 0, ptr %181, align 4, !tbaa !30
  %182 = getelementptr inbounds %struct.Patient, ptr %180, i64 0, i32 2
  store i32 0, ptr %182, align 8, !tbaa !33
  %183 = getelementptr inbounds %struct.Patient, ptr %180, i64 0, i32 3
  store ptr %0, ptr %183, align 8, !tbaa !40
  store i32 1, ptr %180, align 8, !tbaa !28
  %184 = load i32, ptr %15, align 4, !tbaa !39
  %185 = icmp sgt i32 %184, 0
  br i1 %185, label %186, label %190

186:                                              ; preds = %179
  %187 = add nsw i32 %184, -1
  store i32 %187, ptr %15, align 4, !tbaa !39
  tail call void @addList(ptr noundef nonnull %17, ptr noundef nonnull %180) #12
  store i32 3, ptr %182, align 8, !tbaa !33
  %188 = load i32, ptr %181, align 4, !tbaa !30
  %189 = add nsw i32 %188, 3
  store i32 %189, ptr %181, align 4, !tbaa !30
  br label %191

190:                                              ; preds = %179
  tail call void @addList(ptr noundef nonnull %16, ptr noundef nonnull %180) #12
  br label %191

191:                                              ; preds = %190, %186, %171, %1
  %192 = phi ptr [ null, %1 ], [ %135, %186 ], [ %135, %190 ], [ %135, %171 ]
  ret ptr %192
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @addList(ptr noundef %0, ptr noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq ptr %0, null
  br i1 %3, label %8, label %4

4:                                                ; preds = %4, %2
  %5 = phi ptr [ %6, %4 ], [ %0, %2 ]
  %6 = load ptr, ptr %5, align 8, !tbaa !26
  %7 = icmp eq ptr %6, null
  br i1 %7, label %8, label %4, !llvm.loop !46

8:                                                ; preds = %4, %2
  %9 = phi ptr [ undef, %2 ], [ %5, %4 ]
  %10 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #13
  %11 = getelementptr inbounds %struct.List, ptr %10, i64 0, i32 1
  store ptr %1, ptr %11, align 8, !tbaa !27
  store ptr null, ptr %10, align 8, !tbaa !26
  %12 = getelementptr inbounds %struct.List, ptr %10, i64 0, i32 2
  store ptr %9, ptr %12, align 8, !tbaa !47
  store ptr %10, ptr %9, align 8, !tbaa !26
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable
define dso_local void @removeList(ptr nocapture noundef readonly %0, ptr noundef readnone %1) local_unnamed_addr #10 {
  %3 = getelementptr inbounds %struct.List, ptr %0, i64 0, i32 1
  %4 = load ptr, ptr %3, align 8, !tbaa !27
  %5 = icmp eq ptr %4, %1
  br i1 %5, label %12, label %6

6:                                                ; preds = %6, %2
  %7 = phi ptr [ %8, %6 ], [ %0, %2 ]
  %8 = load ptr, ptr %7, align 8, !tbaa !26
  %9 = getelementptr inbounds %struct.List, ptr %8, i64 0, i32 1
  %10 = load ptr, ptr %9, align 8, !tbaa !27
  %11 = icmp eq ptr %10, %1
  br i1 %11, label %12, label %6, !llvm.loop !48

12:                                               ; preds = %6, %2
  %13 = phi ptr [ %0, %2 ], [ %8, %6 ]
  %14 = getelementptr inbounds %struct.List, ptr %13, i64 0, i32 2
  %15 = load ptr, ptr %14, align 8, !tbaa !47
  %16 = load ptr, ptr %13, align 8, !tbaa !26
  store ptr %16, ptr %15, align 8, !tbaa !26
  %17 = load ptr, ptr %13, align 8, !tbaa !26
  %18 = icmp eq ptr %17, null
  br i1 %18, label %21, label %19

19:                                               ; preds = %12
  %20 = getelementptr inbounds %struct.List, ptr %17, i64 0, i32 2
  store ptr %15, ptr %20, align 8, !tbaa !47
  br label %21

21:                                               ; preds = %19, %12
  ret void
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local float @my_rand(i64 noundef %0) local_unnamed_addr #11 {
  %2 = xor i64 %0, 123459876
  %3 = sdiv i64 %2, 127773
  %4 = mul nsw i64 %3, -127773
  %5 = add i64 %4, %2
  %6 = mul nsw i64 %5, 16807
  %7 = mul nsw i64 %3, -2836
  %8 = add i64 %6, %7
  %9 = xor i64 %8, 123459876
  %10 = icmp slt i64 %8, 0
  %11 = add nsw i64 %9, 2147483647
  %12 = select i1 %10, i64 %11, i64 %9
  %13 = sitofp i64 %12 to double
  %14 = fmul double %13, 0x3E00000000200000
  %15 = fptrunc double %14 to float
  ret float %15
}

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree willreturn }
attributes #5 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #6 = { nofree nosync nounwind memory(read, inaccessiblemem: none) uwtable "min-legal-vector-width"="64" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { nounwind uwtable "min-legal-vector-width"="64" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nofree nounwind }
attributes #10 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { nounwind }
attributes #13 = { nounwind allocsize(0) }

!llvm.ident = !{!0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3, !4}

!0 = !{!"clang version 16.0.0"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"long", !7, i64 0}
!11 = !{!12, !12, i64 0}
!12 = !{!"any pointer", !7, i64 0}
!13 = !{!14, !14, i64 0}
!14 = !{!"long long", !7, i64 0}
!15 = !{!16, !12, i64 32}
!16 = !{!"Village", !7, i64 0, !12, i64 32, !17, i64 40, !18, i64 64, !6, i64 176, !14, i64 184}
!17 = !{!"List", !12, i64 0, !12, i64 8, !12, i64 16}
!18 = !{!"Hosp", !6, i64 0, !6, i64 4, !6, i64 8, !17, i64 16, !17, i64 40, !17, i64 64, !17, i64 88}
!19 = !{!16, !6, i64 176}
!20 = !{!16, !14, i64 184}
!21 = !{!16, !6, i64 64}
!22 = !{!16, !6, i64 68}
!23 = !{!16, !6, i64 72}
!24 = !{!16, !12, i64 56}
!25 = !{!16, !12, i64 40}
!26 = !{!17, !12, i64 0}
!27 = !{!17, !12, i64 8}
!28 = !{!29, !6, i64 0}
!29 = !{!"Patient", !6, i64 0, !6, i64 4, !6, i64 8, !12, i64 16}
!30 = !{!29, !6, i64 4}
!31 = distinct !{!31, !32}
!32 = !{!"llvm.loop.mustprogress"}
!33 = !{!29, !6, i64 8}
!34 = distinct !{!34, !32}
!35 = distinct !{!35, !32}
!36 = distinct !{!36, !32}
!37 = distinct !{!37, !32, !38}
!38 = !{!"llvm.loop.unswitch.partial.disable"}
!39 = !{!18, !6, i64 4}
!40 = !{!29, !12, i64 16}
!41 = distinct !{!41, !32}
!42 = distinct !{!42, !32}
!43 = !{!16, !12, i64 128}
!44 = !{!16, !12, i64 104}
!45 = !{!16, !12, i64 80}
!46 = distinct !{!46, !32}
!47 = !{!17, !12, i64 16}
!48 = distinct !{!48, !32}
