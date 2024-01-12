; ModuleID = 'linkedOpt.ll'
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
  %8 = tail call i64 @strtol(ptr nocapture noundef nonnull %7, ptr noundef null, i32 noundef 10) #13
  %9 = trunc i64 %8 to i32
  store i32 %9, ptr @max_level, align 4, !tbaa !5
  %10 = getelementptr inbounds ptr, ptr %1, i64 2
  %11 = load ptr, ptr %10, align 8, !tbaa !11
  %12 = tail call i64 @strtol(ptr nocapture noundef nonnull %11, ptr noundef null, i32 noundef 10) #13
  store i64 %12, ptr @max_time, align 8, !tbaa !9
  %13 = getelementptr inbounds ptr, ptr %1, i64 3
  %14 = load ptr, ptr %13, align 8, !tbaa !11
  %15 = tail call i64 @strtol(ptr nocapture noundef nonnull %14, ptr noundef null, i32 noundef 10) #13
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
  br i1 %4, label %common.ret1, label %5

common.ret1:                                      ; preds = %5, %3
  %common.ret1.op = phi ptr [ %6, %5 ], [ null, %3 ]
  ret ptr %common.ret1.op

5:                                                ; preds = %3
  %6 = tail call noalias dereferenceable_or_null(192) ptr @malloc(i64 noundef 192) #14
  %7 = add nsw i32 %0, -1
  %8 = shl nsw i32 %1, 2
  %9 = or i32 %8, 1
  %10 = add i32 %8, 4
  %11 = tail call ptr @alloc_tree(i32 noundef %7, i32 noundef %10, ptr noundef %6)
  %12 = or i32 %8, 3
  %13 = tail call ptr @alloc_tree(i32 noundef %7, i32 noundef %12, ptr noundef %6)
  %14 = or i32 %8, 2
  %15 = tail call ptr @alloc_tree(i32 noundef %7, i32 noundef %14, ptr noundef %6)
  %16 = tail call ptr @alloc_tree(i32 noundef %7, i32 noundef %9, ptr noundef %6)
  %17 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 1
  store ptr %2, ptr %17, align 8, !tbaa !15
  %18 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 4
  store i32 %1, ptr %18, align 8, !tbaa !19
  %19 = sext i32 %1 to i64
  %20 = load i64, ptr @seed, align 8, !tbaa !13
  %21 = add nsw i64 %20, 127773
  %22 = mul nsw i64 %21, %19
  %23 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 5
  store i64 %22, ptr %23, align 8, !tbaa !20
  %24 = tail call double @ldexp(double 1.000000e+00, i32 %7) #13
  %25 = fptosi double %24 to i32
  %26 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 3
  store i32 %25, ptr %26, align 8, !tbaa !21
  %27 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 3, i32 1
  store i32 %25, ptr %27, align 4, !tbaa !22
  %28 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 3, i32 2
  store i32 0, ptr %28, align 8, !tbaa !23
  %29 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 3, i32 3
  %30 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 2
  %31 = getelementptr inbounds %struct.Village, ptr %6, i64 0, i32 2, i32 2
  store ptr null, ptr %31, align 8, !tbaa !24
  store ptr null, ptr %30, align 8, !tbaa !25
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(96) %29, i8 0, i64 96, i1 false)
  store ptr %16, ptr %6, align 8, !tbaa !11
  %32 = getelementptr inbounds i8, ptr %6, i64 8
  store ptr %15, ptr %32, align 8, !tbaa !11
  %33 = getelementptr inbounds i8, ptr %6, i64 16
  store ptr %13, ptr %33, align 8, !tbaa !11
  %34 = getelementptr inbounds i8, ptr %6, i64 24
  store ptr %11, ptr %34, align 8, !tbaa !11
  br label %common.ret1
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nofree willreturn
declare double @ldexp(double, i32) local_unnamed_addr #4

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nofree nosync nounwind memory(read, inaccessiblemem: none) uwtable
define dso_local { <2 x float>, float } @get_results(ptr noundef readonly %0) local_unnamed_addr #6 {
  %2 = icmp eq ptr %0, null
  br i1 %2, label %.loopexit, label %3

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
  br i1 %33, label %.loopexit, label %.preheader.preheader

.preheader.preheader:                             ; preds = %3
  br label %.preheader

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %34 = phi ptr [ %47, %.preheader ], [ %32, %.preheader.preheader ]
  %35 = phi float [ %41, %.preheader ], [ %26, %.preheader.preheader ]
  %36 = phi <2 x float> [ %46, %.preheader ], [ %30, %.preheader.preheader ]
  %37 = getelementptr inbounds %struct.List, ptr %34, i64 0, i32 1
  %38 = load ptr, ptr %37, align 8, !tbaa !27
  %39 = load i32, ptr %38, align 8, !tbaa !28
  %40 = sitofp i32 %39 to float
  %41 = fadd float %35, %40
  %42 = getelementptr inbounds %struct.Patient, ptr %38, i64 0, i32 1
  %43 = load i32, ptr %42, align 4, !tbaa !30
  %44 = sitofp i32 %43 to float
  %45 = insertelement <2 x float> <float 1.000000e+00, float poison>, float %44, i64 1
  %46 = fadd <2 x float> %36, %45
  %47 = load ptr, ptr %34, align 8, !tbaa !26
  %48 = icmp eq ptr %47, null
  br i1 %48, label %.loopexit.loopexit, label %.preheader, !llvm.loop !31

.loopexit.loopexit:                               ; preds = %.preheader
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %3, %1
  %49 = phi <2 x float> [ zeroinitializer, %1 ], [ %30, %3 ], [ %46, %.loopexit.loopexit ]
  %50 = phi float [ 0.000000e+00, %1 ], [ %26, %3 ], [ %41, %.loopexit.loopexit ]
  %51 = insertvalue { <2 x float>, float } poison, <2 x float> %49, 0
  %52 = insertvalue { <2 x float>, float } %51, float %50, 1
  ret { <2 x float>, float } %52
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @check_patients_inside(ptr noundef %0, ptr noundef readonly %1) local_unnamed_addr #0 {
  %3 = icmp eq ptr %1, null
  br i1 %3, label %.loopexit, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 1
  %6 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5
  %7 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 2
  %8 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5, i32 1
  br label %9

9:                                                ; preds = %41, %4
  %10 = phi ptr [ %1, %4 ], [ %42, %41 ]
  %11 = getelementptr inbounds %struct.List, ptr %10, i64 0, i32 1
  %12 = load ptr, ptr %11, align 8, !tbaa !27
  %13 = getelementptr inbounds %struct.Patient, ptr %12, i64 0, i32 2
  %14 = load i32, ptr %13, align 8, !tbaa !33
  %15 = add nsw i32 %14, -1
  store i32 %15, ptr %13, align 8, !tbaa !33
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %41

17:                                               ; preds = %9
  %18 = load i32, ptr %5, align 4, !tbaa !22
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %5, align 4, !tbaa !22
  %20 = load ptr, ptr %8, align 8, !tbaa !27
  %21 = icmp eq ptr %20, %12
  br i1 %21, label %.loopexit.i, label %.preheader.i.preheader

.preheader.i.preheader:                           ; preds = %17
  br label %.preheader.i

.preheader.i:                                     ; preds = %.preheader.i.preheader, %.preheader.i
  %22 = phi ptr [ %23, %.preheader.i ], [ %6, %.preheader.i.preheader ]
  %23 = load ptr, ptr %22, align 8, !tbaa !26
  %24 = getelementptr inbounds %struct.List, ptr %23, i64 0, i32 1
  %25 = load ptr, ptr %24, align 8, !tbaa !27
  %26 = icmp eq ptr %25, %12
  br i1 %26, label %.loopexit.i.loopexit, label %.preheader.i, !llvm.loop !34

.loopexit.i.loopexit:                             ; preds = %.preheader.i
  br label %.loopexit.i

.loopexit.i:                                      ; preds = %.loopexit.i.loopexit, %17
  %27 = phi ptr [ %6, %17 ], [ %23, %.loopexit.i.loopexit ]
  %28 = getelementptr inbounds %struct.List, ptr %27, i64 0, i32 2
  %29 = load ptr, ptr %28, align 8, !tbaa !35
  %30 = load ptr, ptr %27, align 8, !tbaa !26
  store ptr %30, ptr %29, align 8, !tbaa !26
  %31 = load ptr, ptr %27, align 8, !tbaa !26
  %32 = icmp eq ptr %31, null
  br i1 %32, label %removeList.exit.preheader, label %33

33:                                               ; preds = %.loopexit.i
  %34 = getelementptr inbounds %struct.List, ptr %31, i64 0, i32 2
  store ptr %29, ptr %34, align 8, !tbaa !35
  br label %removeList.exit.preheader

removeList.exit.preheader:                        ; preds = %33, %.loopexit.i
  br label %removeList.exit

removeList.exit:                                  ; preds = %removeList.exit, %removeList.exit.preheader
  %35 = phi ptr [ %36, %removeList.exit ], [ %7, %removeList.exit.preheader ]
  %36 = load ptr, ptr %35, align 8, !tbaa !26
  %37 = icmp eq ptr %36, null
  br i1 %37, label %addList.exit, label %removeList.exit, !llvm.loop !36

addList.exit:                                     ; preds = %removeList.exit
  %38 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %39 = getelementptr inbounds %struct.List, ptr %38, i64 0, i32 1
  store ptr %12, ptr %39, align 8, !tbaa !27
  store ptr null, ptr %38, align 8, !tbaa !26
  %40 = getelementptr inbounds %struct.List, ptr %38, i64 0, i32 2
  store ptr %35, ptr %40, align 8, !tbaa !35
  store ptr %38, ptr %35, align 8, !tbaa !26
  br label %41

41:                                               ; preds = %addList.exit, %9
  %42 = load ptr, ptr %10, align 8, !tbaa !26
  %43 = icmp eq ptr %42, null
  br i1 %43, label %.loopexit.loopexit, label %9, !llvm.loop !37

.loopexit.loopexit:                               ; preds = %41
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  ret void
}

; Function Attrs: nofree nounwind uwtable
define dso_local ptr @check_patients_assess(ptr noundef %0, ptr noundef readonly %1) local_unnamed_addr #0 {
  %3 = icmp eq ptr %1, null
  br i1 %3, label %.loopexit, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 4
  %6 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 5
  %7 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 1
  %8 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 4
  %9 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 6
  %10 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5
  %11 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 4, i32 1
  br label %12

12:                                               ; preds = %93, %4
  %13 = phi ptr [ %1, %4 ], [ %95, %93 ]
  %14 = phi ptr [ null, %4 ], [ %94, %93 ]
  %15 = getelementptr inbounds %struct.List, ptr %13, i64 0, i32 1
  %16 = load ptr, ptr %15, align 8, !tbaa !27
  %17 = getelementptr inbounds %struct.Patient, ptr %16, i64 0, i32 2
  %18 = load i32, ptr %17, align 8, !tbaa !33
  %19 = add nsw i32 %18, -1
  store i32 %19, ptr %17, align 8, !tbaa !33
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %93

21:                                               ; preds = %12
  %22 = load i64, ptr %6, align 8, !tbaa !20
  %23 = xor i64 %22, 123459876
  %24 = sdiv i64 %23, 127773
  %25 = mul nsw i64 %24, -127773
  %26 = add i64 %25, %23
  %27 = mul nsw i64 %26, 16807
  %28 = mul nsw i64 %24, -2836
  %29 = add i64 %27, %28
  %30 = xor i64 %29, 123459876
  %31 = icmp slt i64 %29, 0
  %32 = add nsw i64 %30, 2147483647
  %33 = select i1 %31, i64 %32, i64 %30
  %34 = sitofp i64 %33 to double
  %35 = fmul double %34, 0x3E00000000200000
  %36 = fptrunc double %35 to float
  %37 = fmul float %36, 0x41E0000000000000
  %38 = fptosi float %37 to i64
  store i64 %38, ptr %6, align 8, !tbaa !20
  %39 = load i32, ptr %5, align 8, !tbaa !19
  %40 = fpext float %36 to double
  %41 = fcmp ogt double %40, 1.000000e-01
  %42 = icmp eq i32 %39, 0
  %43 = select i1 %41, i1 true, i1 %42
  br i1 %43, label %44, label %69

44:                                               ; preds = %21
  %45 = load ptr, ptr %11, align 8, !tbaa !27
  %46 = icmp eq ptr %45, %16
  br i1 %46, label %.loopexit.i, label %.preheader.i.preheader

.preheader.i.preheader:                           ; preds = %44
  br label %.preheader.i

.preheader.i:                                     ; preds = %.preheader.i.preheader, %.preheader.i
  %47 = phi ptr [ %48, %.preheader.i ], [ %8, %.preheader.i.preheader ]
  %48 = load ptr, ptr %47, align 8, !tbaa !26
  %49 = getelementptr inbounds %struct.List, ptr %48, i64 0, i32 1
  %50 = load ptr, ptr %49, align 8, !tbaa !27
  %51 = icmp eq ptr %50, %16
  br i1 %51, label %.loopexit.i.loopexit, label %.preheader.i, !llvm.loop !34

.loopexit.i.loopexit:                             ; preds = %.preheader.i
  br label %.loopexit.i

.loopexit.i:                                      ; preds = %.loopexit.i.loopexit, %44
  %52 = phi ptr [ %8, %44 ], [ %48, %.loopexit.i.loopexit ]
  %53 = getelementptr inbounds %struct.List, ptr %52, i64 0, i32 2
  %54 = load ptr, ptr %53, align 8, !tbaa !35
  %55 = load ptr, ptr %52, align 8, !tbaa !26
  store ptr %55, ptr %54, align 8, !tbaa !26
  %56 = load ptr, ptr %52, align 8, !tbaa !26
  %57 = icmp eq ptr %56, null
  br i1 %57, label %removeList.exit.preheader, label %58

58:                                               ; preds = %.loopexit.i
  %59 = getelementptr inbounds %struct.List, ptr %56, i64 0, i32 2
  store ptr %54, ptr %59, align 8, !tbaa !35
  br label %removeList.exit.preheader

removeList.exit.preheader:                        ; preds = %58, %.loopexit.i
  br label %removeList.exit

removeList.exit:                                  ; preds = %removeList.exit, %removeList.exit.preheader
  %60 = phi ptr [ %61, %removeList.exit ], [ %10, %removeList.exit.preheader ]
  %61 = load ptr, ptr %60, align 8, !tbaa !26
  %62 = icmp eq ptr %61, null
  br i1 %62, label %addList.exit, label %removeList.exit, !llvm.loop !36

addList.exit:                                     ; preds = %removeList.exit
  %63 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %64 = getelementptr inbounds %struct.List, ptr %63, i64 0, i32 1
  store ptr %16, ptr %64, align 8, !tbaa !27
  store ptr null, ptr %63, align 8, !tbaa !26
  %65 = getelementptr inbounds %struct.List, ptr %63, i64 0, i32 2
  store ptr %60, ptr %65, align 8, !tbaa !35
  store ptr %63, ptr %60, align 8, !tbaa !26
  store i32 10, ptr %17, align 8, !tbaa !33
  %66 = getelementptr inbounds %struct.Patient, ptr %16, i64 0, i32 1
  %67 = load i32, ptr %66, align 4, !tbaa !30
  %68 = add nsw i32 %67, 10
  store i32 %68, ptr %66, align 4, !tbaa !30
  br label %93

69:                                               ; preds = %21
  %70 = load i32, ptr %7, align 4, !tbaa !22
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %7, align 4, !tbaa !22
  %72 = load ptr, ptr %11, align 8, !tbaa !27
  %73 = icmp eq ptr %72, %16
  br i1 %73, label %.loopexit.i3, label %.preheader.i2.preheader

.preheader.i2.preheader:                          ; preds = %69
  br label %.preheader.i2

.preheader.i2:                                    ; preds = %.preheader.i2.preheader, %.preheader.i2
  %74 = phi ptr [ %75, %.preheader.i2 ], [ %8, %.preheader.i2.preheader ]
  %75 = load ptr, ptr %74, align 8, !tbaa !26
  %76 = getelementptr inbounds %struct.List, ptr %75, i64 0, i32 1
  %77 = load ptr, ptr %76, align 8, !tbaa !27
  %78 = icmp eq ptr %77, %16
  br i1 %78, label %.loopexit.i3.loopexit, label %.preheader.i2, !llvm.loop !34

.loopexit.i3.loopexit:                            ; preds = %.preheader.i2
  br label %.loopexit.i3

.loopexit.i3:                                     ; preds = %.loopexit.i3.loopexit, %69
  %79 = phi ptr [ %8, %69 ], [ %75, %.loopexit.i3.loopexit ]
  %80 = getelementptr inbounds %struct.List, ptr %79, i64 0, i32 2
  %81 = load ptr, ptr %80, align 8, !tbaa !35
  %82 = load ptr, ptr %79, align 8, !tbaa !26
  store ptr %82, ptr %81, align 8, !tbaa !26
  %83 = load ptr, ptr %79, align 8, !tbaa !26
  %84 = icmp eq ptr %83, null
  br i1 %84, label %removeList.exit4.preheader, label %85

85:                                               ; preds = %.loopexit.i3
  %86 = getelementptr inbounds %struct.List, ptr %83, i64 0, i32 2
  store ptr %81, ptr %86, align 8, !tbaa !35
  br label %removeList.exit4.preheader

removeList.exit4.preheader:                       ; preds = %85, %.loopexit.i3
  br label %removeList.exit4

removeList.exit4:                                 ; preds = %removeList.exit4, %removeList.exit4.preheader
  %87 = phi ptr [ %88, %removeList.exit4 ], [ %9, %removeList.exit4.preheader ]
  %88 = load ptr, ptr %87, align 8, !tbaa !26
  %89 = icmp eq ptr %88, null
  br i1 %89, label %addList.exit5, label %removeList.exit4, !llvm.loop !36

addList.exit5:                                    ; preds = %removeList.exit4
  %90 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %91 = getelementptr inbounds %struct.List, ptr %90, i64 0, i32 1
  store ptr %16, ptr %91, align 8, !tbaa !27
  store ptr null, ptr %90, align 8, !tbaa !26
  %92 = getelementptr inbounds %struct.List, ptr %90, i64 0, i32 2
  store ptr %87, ptr %92, align 8, !tbaa !35
  store ptr %90, ptr %87, align 8, !tbaa !26
  br label %93

93:                                               ; preds = %addList.exit5, %addList.exit, %12
  %94 = phi ptr [ %14, %addList.exit ], [ %9, %addList.exit5 ], [ %14, %12 ]
  %95 = load ptr, ptr %13, align 8, !tbaa !26
  %96 = icmp eq ptr %95, null
  br i1 %96, label %.loopexit.loopexit, label %12, !llvm.loop !38

.loopexit.loopexit:                               ; preds = %93
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  %97 = phi ptr [ null, %2 ], [ %94, %.loopexit.loopexit ]
  ret ptr %97
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @check_patients_waiting(ptr noundef %0, ptr noundef readonly %1) local_unnamed_addr #0 {
  %3 = icmp eq ptr %1, null
  br i1 %3, label %.loopexit, label %4

4:                                                ; preds = %2
  %5 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 1
  %6 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 3
  %7 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 4
  %8 = load i32, ptr %5, align 4, !tbaa !22
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %.preheader, label %.preheader4.preheader

.preheader4.preheader:                            ; preds = %4
  br label %.preheader4

.preheader:                                       ; preds = %4
  %10 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 3, i32 1
  br label %19

.preheader4:                                      ; preds = %.preheader4.preheader, %.preheader4
  %11 = phi ptr [ %17, %.preheader4 ], [ %1, %.preheader4.preheader ]
  %12 = getelementptr inbounds %struct.List, ptr %11, i64 0, i32 1
  %13 = load ptr, ptr %12, align 8, !tbaa !27
  %14 = getelementptr inbounds %struct.Patient, ptr %13, i64 0, i32 1
  %15 = load i32, ptr %14, align 4, !tbaa !30
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %14, align 4, !tbaa !30
  %17 = load ptr, ptr %11, align 8, !tbaa !26
  %18 = icmp eq ptr %17, null
  br i1 %18, label %.loopexit.loopexit1, label %.preheader4, !llvm.loop !39

19:                                               ; preds = %56, %.preheader
  %20 = phi i32 [ %8, %.preheader ], [ %57, %56 ]
  %21 = phi ptr [ %1, %.preheader ], [ %58, %56 ]
  %22 = getelementptr inbounds %struct.List, ptr %21, i64 0, i32 1
  %23 = load ptr, ptr %22, align 8, !tbaa !27
  %24 = icmp sgt i32 %20, 0
  br i1 %24, label %25, label %52

25:                                               ; preds = %19
  %26 = add nsw i32 %20, -1
  store i32 %26, ptr %5, align 4, !tbaa !22
  %27 = getelementptr inbounds %struct.Patient, ptr %23, i64 0, i32 2
  store i32 3, ptr %27, align 8, !tbaa !33
  %28 = getelementptr inbounds %struct.Patient, ptr %23, i64 0, i32 1
  %29 = load i32, ptr %28, align 4, !tbaa !30
  %30 = add nsw i32 %29, 3
  store i32 %30, ptr %28, align 4, !tbaa !30
  %31 = load ptr, ptr %10, align 8, !tbaa !27
  %32 = icmp eq ptr %31, %23
  br i1 %32, label %.loopexit.i, label %.preheader.i.preheader

.preheader.i.preheader:                           ; preds = %25
  br label %.preheader.i

.preheader.i:                                     ; preds = %.preheader.i.preheader, %.preheader.i
  %33 = phi ptr [ %34, %.preheader.i ], [ %6, %.preheader.i.preheader ]
  %34 = load ptr, ptr %33, align 8, !tbaa !26
  %35 = getelementptr inbounds %struct.List, ptr %34, i64 0, i32 1
  %36 = load ptr, ptr %35, align 8, !tbaa !27
  %37 = icmp eq ptr %36, %23
  br i1 %37, label %.loopexit.i.loopexit, label %.preheader.i, !llvm.loop !34

.loopexit.i.loopexit:                             ; preds = %.preheader.i
  br label %.loopexit.i

.loopexit.i:                                      ; preds = %.loopexit.i.loopexit, %25
  %38 = phi ptr [ %6, %25 ], [ %34, %.loopexit.i.loopexit ]
  %39 = getelementptr inbounds %struct.List, ptr %38, i64 0, i32 2
  %40 = load ptr, ptr %39, align 8, !tbaa !35
  %41 = load ptr, ptr %38, align 8, !tbaa !26
  store ptr %41, ptr %40, align 8, !tbaa !26
  %42 = load ptr, ptr %38, align 8, !tbaa !26
  %43 = icmp eq ptr %42, null
  br i1 %43, label %removeList.exit.preheader, label %44

44:                                               ; preds = %.loopexit.i
  %45 = getelementptr inbounds %struct.List, ptr %42, i64 0, i32 2
  store ptr %40, ptr %45, align 8, !tbaa !35
  br label %removeList.exit.preheader

removeList.exit.preheader:                        ; preds = %44, %.loopexit.i
  br label %removeList.exit

removeList.exit:                                  ; preds = %removeList.exit, %removeList.exit.preheader
  %46 = phi ptr [ %47, %removeList.exit ], [ %7, %removeList.exit.preheader ]
  %47 = load ptr, ptr %46, align 8, !tbaa !26
  %48 = icmp eq ptr %47, null
  br i1 %48, label %addList.exit, label %removeList.exit, !llvm.loop !36

addList.exit:                                     ; preds = %removeList.exit
  %49 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %50 = getelementptr inbounds %struct.List, ptr %49, i64 0, i32 1
  store ptr %23, ptr %50, align 8, !tbaa !27
  store ptr null, ptr %49, align 8, !tbaa !26
  %51 = getelementptr inbounds %struct.List, ptr %49, i64 0, i32 2
  store ptr %46, ptr %51, align 8, !tbaa !35
  store ptr %49, ptr %46, align 8, !tbaa !26
  br label %56

52:                                               ; preds = %19
  %53 = getelementptr inbounds %struct.Patient, ptr %23, i64 0, i32 1
  %54 = load i32, ptr %53, align 4, !tbaa !30
  %55 = add nsw i32 %54, 1
  store i32 %55, ptr %53, align 4, !tbaa !30
  br label %56

56:                                               ; preds = %52, %addList.exit
  %57 = phi i32 [ %20, %52 ], [ %26, %addList.exit ]
  %58 = load ptr, ptr %21, align 8, !tbaa !26
  %59 = icmp eq ptr %58, null
  br i1 %59, label %.loopexit.loopexit, label %19, !llvm.loop !40

.loopexit.loopexit:                               ; preds = %56
  br label %.loopexit

.loopexit.loopexit1:                              ; preds = %.preheader4
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit1, %.loopexit.loopexit, %2
  ret void
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @put_in_hosp(ptr noundef %0, ptr noundef %1) local_unnamed_addr #0 {
  %3 = load i32, ptr %1, align 8, !tbaa !28
  %4 = add nsw i32 %3, 1
  store i32 %4, ptr %1, align 8, !tbaa !28
  %5 = getelementptr inbounds %struct.Hosp, ptr %0, i64 0, i32 1
  %6 = load i32, ptr %5, align 4, !tbaa !42
  %7 = icmp sgt i32 %6, 0
  br i1 %7, label %8, label %22

8:                                                ; preds = %2
  %9 = add nsw i32 %6, -1
  store i32 %9, ptr %5, align 4, !tbaa !42
  %10 = getelementptr inbounds %struct.Hosp, ptr %0, i64 0, i32 4
  br label %11

11:                                               ; preds = %11, %8
  %12 = phi ptr [ %13, %11 ], [ %10, %8 ]
  %13 = load ptr, ptr %12, align 8, !tbaa !26
  %14 = icmp eq ptr %13, null
  br i1 %14, label %addList.exit, label %11, !llvm.loop !36

addList.exit:                                     ; preds = %11
  %15 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %16 = getelementptr inbounds %struct.List, ptr %15, i64 0, i32 1
  store ptr %1, ptr %16, align 8, !tbaa !27
  store ptr null, ptr %15, align 8, !tbaa !26
  %17 = getelementptr inbounds %struct.List, ptr %15, i64 0, i32 2
  store ptr %12, ptr %17, align 8, !tbaa !35
  store ptr %15, ptr %12, align 8, !tbaa !26
  %18 = getelementptr inbounds %struct.Patient, ptr %1, i64 0, i32 2
  store i32 3, ptr %18, align 8, !tbaa !33
  %19 = getelementptr inbounds %struct.Patient, ptr %1, i64 0, i32 1
  %20 = load i32, ptr %19, align 4, !tbaa !30
  %21 = add nsw i32 %20, 3
  store i32 %21, ptr %19, align 4, !tbaa !30
  br label %31

22:                                               ; preds = %2
  %23 = getelementptr inbounds %struct.Hosp, ptr %0, i64 0, i32 3
  br label %24

24:                                               ; preds = %24, %22
  %25 = phi ptr [ %26, %24 ], [ %23, %22 ]
  %26 = load ptr, ptr %25, align 8, !tbaa !26
  %27 = icmp eq ptr %26, null
  br i1 %27, label %addList.exit1, label %24, !llvm.loop !36

addList.exit1:                                    ; preds = %24
  %28 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %29 = getelementptr inbounds %struct.List, ptr %28, i64 0, i32 1
  store ptr %1, ptr %29, align 8, !tbaa !27
  store ptr null, ptr %28, align 8, !tbaa !26
  %30 = getelementptr inbounds %struct.List, ptr %28, i64 0, i32 2
  store ptr %25, ptr %30, align 8, !tbaa !35
  store ptr %28, ptr %25, align 8, !tbaa !26
  br label %31

31:                                               ; preds = %addList.exit1, %addList.exit
  ret void
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(write, argmem: readwrite, inaccessiblemem: readwrite) uwtable
define dso_local noalias ptr @generate_patient(ptr noundef %0) local_unnamed_addr #7 {
  %2 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 5
  %3 = load i64, ptr %2, align 8, !tbaa !20
  %4 = xor i64 %3, 123459876
  %5 = sdiv i64 %4, 127773
  %6 = mul nsw i64 %5, -127773
  %7 = add i64 %6, %4
  %8 = mul nsw i64 %7, 16807
  %9 = mul nsw i64 %5, -2836
  %10 = add i64 %8, %9
  %11 = xor i64 %10, 123459876
  %12 = icmp slt i64 %10, 0
  %13 = add nsw i64 %11, 2147483647
  %14 = select i1 %12, i64 %13, i64 %11
  %15 = sitofp i64 %14 to double
  %16 = fmul double %15, 0x3E00000000200000
  %17 = fptrunc double %16 to float
  %18 = fmul float %17, 0x41E0000000000000
  %19 = fptosi float %18 to i64
  store i64 %19, ptr %2, align 8, !tbaa !20
  %20 = fpext float %17 to double
  %21 = fcmp ogt double %20, 6.660000e-01
  br i1 %21, label %22, label %27

22:                                               ; preds = %1
  %23 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  store i32 0, ptr %23, align 8, !tbaa !28
  %24 = getelementptr inbounds %struct.Patient, ptr %23, i64 0, i32 1
  store i32 0, ptr %24, align 4, !tbaa !30
  %25 = getelementptr inbounds %struct.Patient, ptr %23, i64 0, i32 2
  store i32 0, ptr %25, align 8, !tbaa !33
  %26 = getelementptr inbounds %struct.Patient, ptr %23, i64 0, i32 3
  store ptr %0, ptr %26, align 8, !tbaa !43
  br label %27

27:                                               ; preds = %22, %1
  %28 = phi ptr [ %23, %22 ], [ null, %1 ]
  ret ptr %28
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #8 {
  %3 = icmp slt i32 %0, 4
  br i1 %3, label %4, label %5

4:                                                ; preds = %2
  store i32 3, ptr @max_level, align 4, !tbaa !5
  store i64 15, ptr @max_time, align 8, !tbaa !9
  br label %dealwithargs.exit

5:                                                ; preds = %2
  %6 = getelementptr inbounds ptr, ptr %1, i64 1
  %7 = load ptr, ptr %6, align 8, !tbaa !11
  %8 = tail call i64 @strtol(ptr nocapture noundef nonnull %7, ptr noundef null, i32 noundef 10) #13
  %9 = trunc i64 %8 to i32
  store i32 %9, ptr @max_level, align 4, !tbaa !5
  %10 = getelementptr inbounds ptr, ptr %1, i64 2
  %11 = load ptr, ptr %10, align 8, !tbaa !11
  %12 = tail call i64 @strtol(ptr nocapture noundef nonnull %11, ptr noundef null, i32 noundef 10) #13
  store i64 %12, ptr @max_time, align 8, !tbaa !9
  %13 = getelementptr inbounds ptr, ptr %1, i64 3
  %14 = load ptr, ptr %13, align 8, !tbaa !11
  %15 = tail call i64 @strtol(ptr nocapture noundef nonnull %14, ptr noundef null, i32 noundef 10) #13
  %16 = load i32, ptr @max_level, align 4, !tbaa !5
  %17 = load i64, ptr @max_time, align 8, !tbaa !9
  %18 = trunc i64 %17 to i32
  br label %dealwithargs.exit

dealwithargs.exit:                                ; preds = %5, %4
  %19 = phi i32 [ %18, %5 ], [ 15, %4 ]
  %20 = phi i32 [ %16, %5 ], [ 3, %4 ]
  %21 = phi i64 [ %15, %5 ], [ 4, %4 ]
  store i64 %21, ptr @seed, align 8, !tbaa !13
  %22 = trunc i64 %21 to i32
  %23 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef %20, i32 noundef %19, i32 noundef %22)
  %24 = load i32, ptr @max_level, align 4, !tbaa !5
  %25 = tail call ptr @alloc_tree(i32 noundef %24, i32 noundef 0, ptr noundef null)
  %26 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  %27 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.8)
  %28 = load i64, ptr @max_time, align 8, !tbaa !9
  %29 = icmp sgt i64 %28, 0
  br i1 %29, label %.preheader.preheader, label %.loopexit

.preheader.preheader:                             ; preds = %dealwithargs.exit
  br label %.preheader

.preheader:                                       ; preds = %.preheader.preheader, %36
  %30 = phi i64 [ %38, %36 ], [ 0, %.preheader.preheader ]
  %31 = trunc i64 %30 to i32
  %32 = urem i32 %31, 50
  %33 = icmp eq i32 %32, 0
  br i1 %33, label %34, label %36

34:                                               ; preds = %.preheader
  %35 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef %31)
  br label %36

36:                                               ; preds = %34, %.preheader
  %37 = tail call ptr @sim(ptr noundef %25)
  %38 = add nuw nsw i64 %30, 1
  %39 = load i64, ptr @max_time, align 8, !tbaa !9
  %40 = icmp sgt i64 %39, %38
  br i1 %40, label %.preheader, label %.loopexit.loopexit, !llvm.loop !44

.loopexit.loopexit:                               ; preds = %36
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %dealwithargs.exit
  %41 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.9)
  %42 = tail call { <2 x float>, float } @get_results(ptr noundef %25)
  %43 = extractvalue { <2 x float>, float } %42, 0
  %44 = extractvalue { <2 x float>, float } %42, 1
  %45 = extractelement <2 x float> %43, i64 0
  %46 = extractelement <2 x float> %43, i64 1
  %47 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.10)
  %48 = fpext float %45 to double
  %49 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, double noundef %48)
  %50 = fdiv float %46, %45
  %51 = fpext float %50 to double
  %52 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.6, double noundef %51)
  %53 = fdiv float %44, %45
  %54 = fpext float %53 to double
  %55 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.7, double noundef %54)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #9

; Function Attrs: nofree nounwind uwtable
define dso_local ptr @sim(ptr noundef %0) local_unnamed_addr #0 {
  %2 = icmp eq ptr %0, null
  br i1 %2, label %367, label %3

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
  br i1 %18, label %.loopexit65, label %19

19:                                               ; preds = %3
  %20 = load ptr, ptr %6, align 8, !tbaa !26
  %21 = icmp eq ptr %20, null
  br i1 %21, label %.loopexit65, label %.preheader64

.preheader64:                                     ; preds = %19
  %22 = getelementptr inbounds %struct.List, ptr %6, i64 0, i32 1
  %.promoted = load i32, ptr %15, align 4, !tbaa !42
  br label %23

23:                                               ; preds = %removeList.exit, %.preheader64
  %24 = phi i32 [ %51, %removeList.exit ], [ %.promoted, %.preheader64 ]
  %25 = phi ptr [ %68, %removeList.exit ], [ %20, %.preheader64 ]
  %26 = getelementptr inbounds %struct.List, ptr %25, i64 0, i32 1
  %27 = load ptr, ptr %26, align 8, !tbaa !27
  %28 = load i32, ptr %27, align 8, !tbaa !28
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr %27, align 8, !tbaa !28
  %30 = icmp sgt i32 %24, 0
  br i1 %30, label %31, label %.preheader63.preheader

.preheader63.preheader:                           ; preds = %23
  br label %.preheader63

31:                                               ; preds = %23
  %32 = add nsw i32 %24, -1
  store i32 %32, ptr %15, align 4, !tbaa !42
  br label %33

33:                                               ; preds = %33, %31
  %34 = phi ptr [ %35, %33 ], [ %17, %31 ]
  %35 = load ptr, ptr %34, align 8, !tbaa !26
  %36 = icmp eq ptr %35, null
  br i1 %36, label %addList.exit, label %33, !llvm.loop !36

addList.exit:                                     ; preds = %33
  %37 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %38 = getelementptr inbounds %struct.List, ptr %37, i64 0, i32 1
  store ptr %27, ptr %38, align 8, !tbaa !27
  store ptr null, ptr %37, align 8, !tbaa !26
  %39 = getelementptr inbounds %struct.List, ptr %37, i64 0, i32 2
  store ptr %34, ptr %39, align 8, !tbaa !35
  store ptr %37, ptr %34, align 8, !tbaa !26
  %40 = getelementptr inbounds %struct.Patient, ptr %27, i64 0, i32 2
  store i32 3, ptr %40, align 8, !tbaa !33
  %41 = getelementptr inbounds %struct.Patient, ptr %27, i64 0, i32 1
  %42 = load i32, ptr %41, align 4, !tbaa !30
  %43 = add nsw i32 %42, 3
  store i32 %43, ptr %41, align 4, !tbaa !30
  br label %50

.preheader63:                                     ; preds = %.preheader63.preheader, %.preheader63
  %44 = phi ptr [ %45, %.preheader63 ], [ %16, %.preheader63.preheader ]
  %45 = load ptr, ptr %44, align 8, !tbaa !26
  %46 = icmp eq ptr %45, null
  br i1 %46, label %addList.exit24, label %.preheader63, !llvm.loop !36

addList.exit24:                                   ; preds = %.preheader63
  %47 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %48 = getelementptr inbounds %struct.List, ptr %47, i64 0, i32 1
  store ptr %27, ptr %48, align 8, !tbaa !27
  store ptr null, ptr %47, align 8, !tbaa !26
  %49 = getelementptr inbounds %struct.List, ptr %47, i64 0, i32 2
  store ptr %44, ptr %49, align 8, !tbaa !35
  store ptr %47, ptr %44, align 8, !tbaa !26
  br label %50

50:                                               ; preds = %addList.exit24, %addList.exit
  %51 = phi i32 [ %24, %addList.exit24 ], [ %32, %addList.exit ]
  %52 = load ptr, ptr %26, align 8, !tbaa !27
  %53 = load ptr, ptr %22, align 8, !tbaa !27
  %54 = icmp eq ptr %53, %52
  br i1 %54, label %.loopexit.i, label %.preheader.i.preheader

.preheader.i.preheader:                           ; preds = %50
  br label %.preheader.i

.preheader.i:                                     ; preds = %.preheader.i.preheader, %.preheader.i
  %55 = phi ptr [ %56, %.preheader.i ], [ %6, %.preheader.i.preheader ]
  %56 = load ptr, ptr %55, align 8, !tbaa !26
  %57 = getelementptr inbounds %struct.List, ptr %56, i64 0, i32 1
  %58 = load ptr, ptr %57, align 8, !tbaa !27
  %59 = icmp eq ptr %58, %52
  br i1 %59, label %.loopexit.i.loopexit, label %.preheader.i, !llvm.loop !34

.loopexit.i.loopexit:                             ; preds = %.preheader.i
  br label %.loopexit.i

.loopexit.i:                                      ; preds = %.loopexit.i.loopexit, %50
  %60 = phi ptr [ %6, %50 ], [ %56, %.loopexit.i.loopexit ]
  %61 = getelementptr inbounds %struct.List, ptr %60, i64 0, i32 2
  %62 = load ptr, ptr %61, align 8, !tbaa !35
  %63 = load ptr, ptr %60, align 8, !tbaa !26
  store ptr %63, ptr %62, align 8, !tbaa !26
  %64 = load ptr, ptr %60, align 8, !tbaa !26
  %65 = icmp eq ptr %64, null
  br i1 %65, label %removeList.exit, label %66

66:                                               ; preds = %.loopexit.i
  %67 = getelementptr inbounds %struct.List, ptr %64, i64 0, i32 2
  store ptr %62, ptr %67, align 8, !tbaa !35
  br label %removeList.exit

removeList.exit:                                  ; preds = %66, %.loopexit.i
  %68 = load ptr, ptr %25, align 8, !tbaa !26
  %69 = icmp eq ptr %68, null
  br i1 %69, label %.loopexit65.loopexit, label %23, !llvm.loop !45

.loopexit65.loopexit:                             ; preds = %removeList.exit
  br label %.loopexit65

.loopexit65:                                      ; preds = %.loopexit65.loopexit, %19, %3
  %70 = icmp eq ptr %9, null
  br i1 %70, label %.loopexit62, label %71

71:                                               ; preds = %.loopexit65
  %72 = load ptr, ptr %9, align 8, !tbaa !26
  %73 = icmp eq ptr %72, null
  br i1 %73, label %.loopexit62, label %.preheader61

.preheader61:                                     ; preds = %71
  %74 = getelementptr inbounds %struct.List, ptr %9, i64 0, i32 1
  %.promoted83 = load i32, ptr %15, align 4, !tbaa !42
  br label %75

75:                                               ; preds = %removeList.exit29, %.preheader61
  %76 = phi i32 [ %103, %removeList.exit29 ], [ %.promoted83, %.preheader61 ]
  %77 = phi ptr [ %120, %removeList.exit29 ], [ %72, %.preheader61 ]
  %78 = getelementptr inbounds %struct.List, ptr %77, i64 0, i32 1
  %79 = load ptr, ptr %78, align 8, !tbaa !27
  %80 = load i32, ptr %79, align 8, !tbaa !28
  %81 = add nsw i32 %80, 1
  store i32 %81, ptr %79, align 8, !tbaa !28
  %82 = icmp sgt i32 %76, 0
  br i1 %82, label %89, label %.preheader60.preheader

.preheader60.preheader:                           ; preds = %75
  br label %.preheader60

.preheader60:                                     ; preds = %.preheader60.preheader, %.preheader60
  %83 = phi ptr [ %84, %.preheader60 ], [ %16, %.preheader60.preheader ]
  %84 = load ptr, ptr %83, align 8, !tbaa !26
  %85 = icmp eq ptr %84, null
  br i1 %85, label %addList.exit25, label %.preheader60, !llvm.loop !36

addList.exit25:                                   ; preds = %.preheader60
  %86 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %87 = getelementptr inbounds %struct.List, ptr %86, i64 0, i32 1
  store ptr %79, ptr %87, align 8, !tbaa !27
  store ptr null, ptr %86, align 8, !tbaa !26
  %88 = getelementptr inbounds %struct.List, ptr %86, i64 0, i32 2
  store ptr %83, ptr %88, align 8, !tbaa !35
  store ptr %86, ptr %83, align 8, !tbaa !26
  br label %102

89:                                               ; preds = %75
  %90 = add nsw i32 %76, -1
  store i32 %90, ptr %15, align 4, !tbaa !42
  br label %91

91:                                               ; preds = %91, %89
  %92 = phi ptr [ %93, %91 ], [ %17, %89 ]
  %93 = load ptr, ptr %92, align 8, !tbaa !26
  %94 = icmp eq ptr %93, null
  br i1 %94, label %addList.exit26, label %91, !llvm.loop !36

addList.exit26:                                   ; preds = %91
  %95 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %96 = getelementptr inbounds %struct.List, ptr %95, i64 0, i32 1
  store ptr %79, ptr %96, align 8, !tbaa !27
  store ptr null, ptr %95, align 8, !tbaa !26
  %97 = getelementptr inbounds %struct.List, ptr %95, i64 0, i32 2
  store ptr %92, ptr %97, align 8, !tbaa !35
  store ptr %95, ptr %92, align 8, !tbaa !26
  %98 = getelementptr inbounds %struct.Patient, ptr %79, i64 0, i32 2
  store i32 3, ptr %98, align 8, !tbaa !33
  %99 = getelementptr inbounds %struct.Patient, ptr %79, i64 0, i32 1
  %100 = load i32, ptr %99, align 4, !tbaa !30
  %101 = add nsw i32 %100, 3
  store i32 %101, ptr %99, align 4, !tbaa !30
  br label %102

102:                                              ; preds = %addList.exit26, %addList.exit25
  %103 = phi i32 [ %90, %addList.exit26 ], [ %76, %addList.exit25 ]
  %104 = load ptr, ptr %78, align 8, !tbaa !27
  %105 = load ptr, ptr %74, align 8, !tbaa !27
  %106 = icmp eq ptr %105, %104
  br i1 %106, label %.loopexit.i28, label %.preheader.i27.preheader

.preheader.i27.preheader:                         ; preds = %102
  br label %.preheader.i27

.preheader.i27:                                   ; preds = %.preheader.i27.preheader, %.preheader.i27
  %107 = phi ptr [ %108, %.preheader.i27 ], [ %9, %.preheader.i27.preheader ]
  %108 = load ptr, ptr %107, align 8, !tbaa !26
  %109 = getelementptr inbounds %struct.List, ptr %108, i64 0, i32 1
  %110 = load ptr, ptr %109, align 8, !tbaa !27
  %111 = icmp eq ptr %110, %104
  br i1 %111, label %.loopexit.i28.loopexit, label %.preheader.i27, !llvm.loop !34

.loopexit.i28.loopexit:                           ; preds = %.preheader.i27
  br label %.loopexit.i28

.loopexit.i28:                                    ; preds = %.loopexit.i28.loopexit, %102
  %112 = phi ptr [ %9, %102 ], [ %108, %.loopexit.i28.loopexit ]
  %113 = getelementptr inbounds %struct.List, ptr %112, i64 0, i32 2
  %114 = load ptr, ptr %113, align 8, !tbaa !35
  %115 = load ptr, ptr %112, align 8, !tbaa !26
  store ptr %115, ptr %114, align 8, !tbaa !26
  %116 = load ptr, ptr %112, align 8, !tbaa !26
  %117 = icmp eq ptr %116, null
  br i1 %117, label %removeList.exit29, label %118

118:                                              ; preds = %.loopexit.i28
  %119 = getelementptr inbounds %struct.List, ptr %116, i64 0, i32 2
  store ptr %114, ptr %119, align 8, !tbaa !35
  br label %removeList.exit29

removeList.exit29:                                ; preds = %118, %.loopexit.i28
  %120 = load ptr, ptr %77, align 8, !tbaa !26
  %121 = icmp eq ptr %120, null
  br i1 %121, label %.loopexit62.loopexit, label %75, !llvm.loop !45

.loopexit62.loopexit:                             ; preds = %removeList.exit29
  br label %.loopexit62

.loopexit62:                                      ; preds = %.loopexit62.loopexit, %71, %.loopexit65
  %122 = icmp eq ptr %12, null
  br i1 %122, label %.loopexit59, label %123

123:                                              ; preds = %.loopexit62
  %124 = load ptr, ptr %12, align 8, !tbaa !26
  %125 = icmp eq ptr %124, null
  br i1 %125, label %.loopexit59, label %.preheader58

.preheader58:                                     ; preds = %123
  %126 = getelementptr inbounds %struct.List, ptr %12, i64 0, i32 1
  %.promoted84 = load i32, ptr %15, align 4, !tbaa !42
  br label %127

127:                                              ; preds = %removeList.exit34, %.preheader58
  %128 = phi i32 [ %155, %removeList.exit34 ], [ %.promoted84, %.preheader58 ]
  %129 = phi ptr [ %172, %removeList.exit34 ], [ %124, %.preheader58 ]
  %130 = getelementptr inbounds %struct.List, ptr %129, i64 0, i32 1
  %131 = load ptr, ptr %130, align 8, !tbaa !27
  %132 = load i32, ptr %131, align 8, !tbaa !28
  %133 = add nsw i32 %132, 1
  store i32 %133, ptr %131, align 8, !tbaa !28
  %134 = icmp sgt i32 %128, 0
  br i1 %134, label %141, label %.preheader57.preheader

.preheader57.preheader:                           ; preds = %127
  br label %.preheader57

.preheader57:                                     ; preds = %.preheader57.preheader, %.preheader57
  %135 = phi ptr [ %136, %.preheader57 ], [ %16, %.preheader57.preheader ]
  %136 = load ptr, ptr %135, align 8, !tbaa !26
  %137 = icmp eq ptr %136, null
  br i1 %137, label %addList.exit30, label %.preheader57, !llvm.loop !36

addList.exit30:                                   ; preds = %.preheader57
  %138 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %139 = getelementptr inbounds %struct.List, ptr %138, i64 0, i32 1
  store ptr %131, ptr %139, align 8, !tbaa !27
  store ptr null, ptr %138, align 8, !tbaa !26
  %140 = getelementptr inbounds %struct.List, ptr %138, i64 0, i32 2
  store ptr %135, ptr %140, align 8, !tbaa !35
  store ptr %138, ptr %135, align 8, !tbaa !26
  br label %154

141:                                              ; preds = %127
  %142 = add nsw i32 %128, -1
  store i32 %142, ptr %15, align 4, !tbaa !42
  br label %143

143:                                              ; preds = %143, %141
  %144 = phi ptr [ %145, %143 ], [ %17, %141 ]
  %145 = load ptr, ptr %144, align 8, !tbaa !26
  %146 = icmp eq ptr %145, null
  br i1 %146, label %addList.exit31, label %143, !llvm.loop !36

addList.exit31:                                   ; preds = %143
  %147 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %148 = getelementptr inbounds %struct.List, ptr %147, i64 0, i32 1
  store ptr %131, ptr %148, align 8, !tbaa !27
  store ptr null, ptr %147, align 8, !tbaa !26
  %149 = getelementptr inbounds %struct.List, ptr %147, i64 0, i32 2
  store ptr %144, ptr %149, align 8, !tbaa !35
  store ptr %147, ptr %144, align 8, !tbaa !26
  %150 = getelementptr inbounds %struct.Patient, ptr %131, i64 0, i32 2
  store i32 3, ptr %150, align 8, !tbaa !33
  %151 = getelementptr inbounds %struct.Patient, ptr %131, i64 0, i32 1
  %152 = load i32, ptr %151, align 4, !tbaa !30
  %153 = add nsw i32 %152, 3
  store i32 %153, ptr %151, align 4, !tbaa !30
  br label %154

154:                                              ; preds = %addList.exit31, %addList.exit30
  %155 = phi i32 [ %142, %addList.exit31 ], [ %128, %addList.exit30 ]
  %156 = load ptr, ptr %130, align 8, !tbaa !27
  %157 = load ptr, ptr %126, align 8, !tbaa !27
  %158 = icmp eq ptr %157, %156
  br i1 %158, label %.loopexit.i33, label %.preheader.i32.preheader

.preheader.i32.preheader:                         ; preds = %154
  br label %.preheader.i32

.preheader.i32:                                   ; preds = %.preheader.i32.preheader, %.preheader.i32
  %159 = phi ptr [ %160, %.preheader.i32 ], [ %12, %.preheader.i32.preheader ]
  %160 = load ptr, ptr %159, align 8, !tbaa !26
  %161 = getelementptr inbounds %struct.List, ptr %160, i64 0, i32 1
  %162 = load ptr, ptr %161, align 8, !tbaa !27
  %163 = icmp eq ptr %162, %156
  br i1 %163, label %.loopexit.i33.loopexit, label %.preheader.i32, !llvm.loop !34

.loopexit.i33.loopexit:                           ; preds = %.preheader.i32
  br label %.loopexit.i33

.loopexit.i33:                                    ; preds = %.loopexit.i33.loopexit, %154
  %164 = phi ptr [ %12, %154 ], [ %160, %.loopexit.i33.loopexit ]
  %165 = getelementptr inbounds %struct.List, ptr %164, i64 0, i32 2
  %166 = load ptr, ptr %165, align 8, !tbaa !35
  %167 = load ptr, ptr %164, align 8, !tbaa !26
  store ptr %167, ptr %166, align 8, !tbaa !26
  %168 = load ptr, ptr %164, align 8, !tbaa !26
  %169 = icmp eq ptr %168, null
  br i1 %169, label %removeList.exit34, label %170

170:                                              ; preds = %.loopexit.i33
  %171 = getelementptr inbounds %struct.List, ptr %168, i64 0, i32 2
  store ptr %166, ptr %171, align 8, !tbaa !35
  br label %removeList.exit34

removeList.exit34:                                ; preds = %170, %.loopexit.i33
  %172 = load ptr, ptr %129, align 8, !tbaa !26
  %173 = icmp eq ptr %172, null
  br i1 %173, label %.loopexit59.loopexit, label %127, !llvm.loop !45

.loopexit59.loopexit:                             ; preds = %removeList.exit34
  br label %.loopexit59

.loopexit59:                                      ; preds = %.loopexit59.loopexit, %123, %.loopexit62
  %174 = icmp eq ptr %14, null
  br i1 %174, label %.loopexit56, label %175

175:                                              ; preds = %.loopexit59
  %176 = load ptr, ptr %14, align 8, !tbaa !26
  %177 = icmp eq ptr %176, null
  br i1 %177, label %.loopexit56, label %.preheader55

.preheader55:                                     ; preds = %175
  %178 = getelementptr inbounds %struct.List, ptr %14, i64 0, i32 1
  %.promoted85 = load i32, ptr %15, align 4, !tbaa !42
  br label %179

179:                                              ; preds = %removeList.exit39, %.preheader55
  %180 = phi i32 [ %207, %removeList.exit39 ], [ %.promoted85, %.preheader55 ]
  %181 = phi ptr [ %224, %removeList.exit39 ], [ %176, %.preheader55 ]
  %182 = getelementptr inbounds %struct.List, ptr %181, i64 0, i32 1
  %183 = load ptr, ptr %182, align 8, !tbaa !27
  %184 = load i32, ptr %183, align 8, !tbaa !28
  %185 = add nsw i32 %184, 1
  store i32 %185, ptr %183, align 8, !tbaa !28
  %186 = icmp sgt i32 %180, 0
  br i1 %186, label %193, label %.preheader54.preheader

.preheader54.preheader:                           ; preds = %179
  br label %.preheader54

.preheader54:                                     ; preds = %.preheader54.preheader, %.preheader54
  %187 = phi ptr [ %188, %.preheader54 ], [ %16, %.preheader54.preheader ]
  %188 = load ptr, ptr %187, align 8, !tbaa !26
  %189 = icmp eq ptr %188, null
  br i1 %189, label %addList.exit35, label %.preheader54, !llvm.loop !36

addList.exit35:                                   ; preds = %.preheader54
  %190 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %191 = getelementptr inbounds %struct.List, ptr %190, i64 0, i32 1
  store ptr %183, ptr %191, align 8, !tbaa !27
  store ptr null, ptr %190, align 8, !tbaa !26
  %192 = getelementptr inbounds %struct.List, ptr %190, i64 0, i32 2
  store ptr %187, ptr %192, align 8, !tbaa !35
  store ptr %190, ptr %187, align 8, !tbaa !26
  br label %206

193:                                              ; preds = %179
  %194 = add nsw i32 %180, -1
  store i32 %194, ptr %15, align 4, !tbaa !42
  br label %195

195:                                              ; preds = %195, %193
  %196 = phi ptr [ %197, %195 ], [ %17, %193 ]
  %197 = load ptr, ptr %196, align 8, !tbaa !26
  %198 = icmp eq ptr %197, null
  br i1 %198, label %addList.exit36, label %195, !llvm.loop !36

addList.exit36:                                   ; preds = %195
  %199 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %200 = getelementptr inbounds %struct.List, ptr %199, i64 0, i32 1
  store ptr %183, ptr %200, align 8, !tbaa !27
  store ptr null, ptr %199, align 8, !tbaa !26
  %201 = getelementptr inbounds %struct.List, ptr %199, i64 0, i32 2
  store ptr %196, ptr %201, align 8, !tbaa !35
  store ptr %199, ptr %196, align 8, !tbaa !26
  %202 = getelementptr inbounds %struct.Patient, ptr %183, i64 0, i32 2
  store i32 3, ptr %202, align 8, !tbaa !33
  %203 = getelementptr inbounds %struct.Patient, ptr %183, i64 0, i32 1
  %204 = load i32, ptr %203, align 4, !tbaa !30
  %205 = add nsw i32 %204, 3
  store i32 %205, ptr %203, align 4, !tbaa !30
  br label %206

206:                                              ; preds = %addList.exit36, %addList.exit35
  %207 = phi i32 [ %194, %addList.exit36 ], [ %180, %addList.exit35 ]
  %208 = load ptr, ptr %182, align 8, !tbaa !27
  %209 = load ptr, ptr %178, align 8, !tbaa !27
  %210 = icmp eq ptr %209, %208
  br i1 %210, label %.loopexit.i38, label %.preheader.i37.preheader

.preheader.i37.preheader:                         ; preds = %206
  br label %.preheader.i37

.preheader.i37:                                   ; preds = %.preheader.i37.preheader, %.preheader.i37
  %211 = phi ptr [ %212, %.preheader.i37 ], [ %14, %.preheader.i37.preheader ]
  %212 = load ptr, ptr %211, align 8, !tbaa !26
  %213 = getelementptr inbounds %struct.List, ptr %212, i64 0, i32 1
  %214 = load ptr, ptr %213, align 8, !tbaa !27
  %215 = icmp eq ptr %214, %208
  br i1 %215, label %.loopexit.i38.loopexit, label %.preheader.i37, !llvm.loop !34

.loopexit.i38.loopexit:                           ; preds = %.preheader.i37
  br label %.loopexit.i38

.loopexit.i38:                                    ; preds = %.loopexit.i38.loopexit, %206
  %216 = phi ptr [ %14, %206 ], [ %212, %.loopexit.i38.loopexit ]
  %217 = getelementptr inbounds %struct.List, ptr %216, i64 0, i32 2
  %218 = load ptr, ptr %217, align 8, !tbaa !35
  %219 = load ptr, ptr %216, align 8, !tbaa !26
  store ptr %219, ptr %218, align 8, !tbaa !26
  %220 = load ptr, ptr %216, align 8, !tbaa !26
  %221 = icmp eq ptr %220, null
  br i1 %221, label %removeList.exit39, label %222

222:                                              ; preds = %.loopexit.i38
  %223 = getelementptr inbounds %struct.List, ptr %220, i64 0, i32 2
  store ptr %218, ptr %223, align 8, !tbaa !35
  br label %removeList.exit39

removeList.exit39:                                ; preds = %222, %.loopexit.i38
  %224 = load ptr, ptr %181, align 8, !tbaa !26
  %225 = icmp eq ptr %224, null
  br i1 %225, label %.loopexit56.loopexit, label %179, !llvm.loop !45

.loopexit56.loopexit:                             ; preds = %removeList.exit39
  br label %.loopexit56

.loopexit56:                                      ; preds = %.loopexit56.loopexit, %175, %.loopexit59
  %226 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5
  %227 = load ptr, ptr %226, align 8, !tbaa !46
  %228 = icmp eq ptr %227, null
  br i1 %228, label %.loopexit53, label %229

229:                                              ; preds = %.loopexit56
  %230 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 2
  %231 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5, i32 1
  br label %232

232:                                              ; preds = %264, %229
  %233 = phi ptr [ %227, %229 ], [ %265, %264 ]
  %234 = getelementptr inbounds %struct.List, ptr %233, i64 0, i32 1
  %235 = load ptr, ptr %234, align 8, !tbaa !27
  %236 = getelementptr inbounds %struct.Patient, ptr %235, i64 0, i32 2
  %237 = load i32, ptr %236, align 8, !tbaa !33
  %238 = add nsw i32 %237, -1
  store i32 %238, ptr %236, align 8, !tbaa !33
  %239 = icmp eq i32 %238, 0
  br i1 %239, label %240, label %264

240:                                              ; preds = %232
  %241 = load i32, ptr %15, align 4, !tbaa !22
  %242 = add nsw i32 %241, 1
  store i32 %242, ptr %15, align 4, !tbaa !22
  %243 = load ptr, ptr %231, align 8, !tbaa !27
  %244 = icmp eq ptr %243, %235
  br i1 %244, label %.loopexit.i41, label %.preheader.i40.preheader

.preheader.i40.preheader:                         ; preds = %240
  br label %.preheader.i40

.preheader.i40:                                   ; preds = %.preheader.i40.preheader, %.preheader.i40
  %245 = phi ptr [ %246, %.preheader.i40 ], [ %226, %.preheader.i40.preheader ]
  %246 = load ptr, ptr %245, align 8, !tbaa !26
  %247 = getelementptr inbounds %struct.List, ptr %246, i64 0, i32 1
  %248 = load ptr, ptr %247, align 8, !tbaa !27
  %249 = icmp eq ptr %248, %235
  br i1 %249, label %.loopexit.i41.loopexit, label %.preheader.i40, !llvm.loop !34

.loopexit.i41.loopexit:                           ; preds = %.preheader.i40
  br label %.loopexit.i41

.loopexit.i41:                                    ; preds = %.loopexit.i41.loopexit, %240
  %250 = phi ptr [ %226, %240 ], [ %246, %.loopexit.i41.loopexit ]
  %251 = getelementptr inbounds %struct.List, ptr %250, i64 0, i32 2
  %252 = load ptr, ptr %251, align 8, !tbaa !35
  %253 = load ptr, ptr %250, align 8, !tbaa !26
  store ptr %253, ptr %252, align 8, !tbaa !26
  %254 = load ptr, ptr %250, align 8, !tbaa !26
  %255 = icmp eq ptr %254, null
  br i1 %255, label %removeList.exit42.preheader, label %256

256:                                              ; preds = %.loopexit.i41
  %257 = getelementptr inbounds %struct.List, ptr %254, i64 0, i32 2
  store ptr %252, ptr %257, align 8, !tbaa !35
  br label %removeList.exit42.preheader

removeList.exit42.preheader:                      ; preds = %256, %.loopexit.i41
  br label %removeList.exit42

removeList.exit42:                                ; preds = %removeList.exit42, %removeList.exit42.preheader
  %258 = phi ptr [ %259, %removeList.exit42 ], [ %230, %removeList.exit42.preheader ]
  %259 = load ptr, ptr %258, align 8, !tbaa !26
  %260 = icmp eq ptr %259, null
  br i1 %260, label %addList.exit43, label %removeList.exit42, !llvm.loop !36

addList.exit43:                                   ; preds = %removeList.exit42
  %261 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %262 = getelementptr inbounds %struct.List, ptr %261, i64 0, i32 1
  store ptr %235, ptr %262, align 8, !tbaa !27
  store ptr null, ptr %261, align 8, !tbaa !26
  %263 = getelementptr inbounds %struct.List, ptr %261, i64 0, i32 2
  store ptr %258, ptr %263, align 8, !tbaa !35
  store ptr %261, ptr %258, align 8, !tbaa !26
  br label %264

264:                                              ; preds = %addList.exit43, %232
  %265 = load ptr, ptr %233, align 8, !tbaa !26
  %266 = icmp eq ptr %265, null
  br i1 %266, label %.loopexit53.loopexit, label %232, !llvm.loop !37

.loopexit53.loopexit:                             ; preds = %264
  br label %.loopexit53

.loopexit53:                                      ; preds = %.loopexit53.loopexit, %.loopexit56
  %267 = load ptr, ptr %17, align 8, !tbaa !47
  %268 = tail call ptr @check_patients_assess(ptr noundef nonnull %0, ptr noundef %267)
  %269 = load ptr, ptr %16, align 8, !tbaa !48
  %270 = icmp eq ptr %269, null
  br i1 %270, label %.loopexit, label %271

271:                                              ; preds = %.loopexit53
  %272 = load i32, ptr %15, align 4, !tbaa !22
  %273 = icmp sgt i32 %272, 0
  br i1 %273, label %.preheader50, label %.preheader51.preheader

.preheader51.preheader:                           ; preds = %271
  br label %.preheader51

.preheader50:                                     ; preds = %271
  %274 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 3, i32 1
  br label %285

.preheader51:                                     ; preds = %.preheader51.preheader, %.preheader51
  %275 = phi ptr [ %281, %.preheader51 ], [ %269, %.preheader51.preheader ]
  %276 = getelementptr inbounds %struct.List, ptr %275, i64 0, i32 1
  %277 = load ptr, ptr %276, align 8, !tbaa !27
  %278 = getelementptr inbounds %struct.Patient, ptr %277, i64 0, i32 1
  %279 = load i32, ptr %278, align 4, !tbaa !30
  %280 = add nsw i32 %279, 1
  store i32 %280, ptr %278, align 4, !tbaa !30
  %281 = load ptr, ptr %275, align 8, !tbaa !26
  %282 = icmp eq ptr %281, null
  br i1 %282, label %.loopexit.loopexit1, label %.preheader51, !llvm.loop !39

283:                                              ; preds = %322
  %284 = load i32, ptr %15, align 4, !tbaa !22
  br label %285

285:                                              ; preds = %283, %.preheader50
  %286 = phi i32 [ %284, %283 ], [ %272, %.preheader50 ]
  %287 = phi ptr [ %323, %283 ], [ %269, %.preheader50 ]
  %288 = getelementptr inbounds %struct.List, ptr %287, i64 0, i32 1
  %289 = load ptr, ptr %288, align 8, !tbaa !27
  %290 = icmp sgt i32 %286, 0
  br i1 %290, label %291, label %318

291:                                              ; preds = %285
  %292 = add nsw i32 %286, -1
  store i32 %292, ptr %15, align 4, !tbaa !22
  %293 = getelementptr inbounds %struct.Patient, ptr %289, i64 0, i32 2
  store i32 3, ptr %293, align 8, !tbaa !33
  %294 = getelementptr inbounds %struct.Patient, ptr %289, i64 0, i32 1
  %295 = load i32, ptr %294, align 4, !tbaa !30
  %296 = add nsw i32 %295, 3
  store i32 %296, ptr %294, align 4, !tbaa !30
  %297 = load ptr, ptr %274, align 8, !tbaa !27
  %298 = icmp eq ptr %297, %289
  br i1 %298, label %.loopexit.i45, label %.preheader.i44.preheader

.preheader.i44.preheader:                         ; preds = %291
  br label %.preheader.i44

.preheader.i44:                                   ; preds = %.preheader.i44.preheader, %.preheader.i44
  %299 = phi ptr [ %300, %.preheader.i44 ], [ %16, %.preheader.i44.preheader ]
  %300 = load ptr, ptr %299, align 8, !tbaa !26
  %301 = getelementptr inbounds %struct.List, ptr %300, i64 0, i32 1
  %302 = load ptr, ptr %301, align 8, !tbaa !27
  %303 = icmp eq ptr %302, %289
  br i1 %303, label %.loopexit.i45.loopexit, label %.preheader.i44, !llvm.loop !34

.loopexit.i45.loopexit:                           ; preds = %.preheader.i44
  br label %.loopexit.i45

.loopexit.i45:                                    ; preds = %.loopexit.i45.loopexit, %291
  %304 = phi ptr [ %16, %291 ], [ %300, %.loopexit.i45.loopexit ]
  %305 = getelementptr inbounds %struct.List, ptr %304, i64 0, i32 2
  %306 = load ptr, ptr %305, align 8, !tbaa !35
  %307 = load ptr, ptr %304, align 8, !tbaa !26
  store ptr %307, ptr %306, align 8, !tbaa !26
  %308 = load ptr, ptr %304, align 8, !tbaa !26
  %309 = icmp eq ptr %308, null
  br i1 %309, label %removeList.exit46.preheader, label %310

310:                                              ; preds = %.loopexit.i45
  %311 = getelementptr inbounds %struct.List, ptr %308, i64 0, i32 2
  store ptr %306, ptr %311, align 8, !tbaa !35
  br label %removeList.exit46.preheader

removeList.exit46.preheader:                      ; preds = %310, %.loopexit.i45
  br label %removeList.exit46

removeList.exit46:                                ; preds = %removeList.exit46, %removeList.exit46.preheader
  %312 = phi ptr [ %313, %removeList.exit46 ], [ %17, %removeList.exit46.preheader ]
  %313 = load ptr, ptr %312, align 8, !tbaa !26
  %314 = icmp eq ptr %313, null
  br i1 %314, label %addList.exit47, label %removeList.exit46, !llvm.loop !36

addList.exit47:                                   ; preds = %removeList.exit46
  %315 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %316 = getelementptr inbounds %struct.List, ptr %315, i64 0, i32 1
  store ptr %289, ptr %316, align 8, !tbaa !27
  store ptr null, ptr %315, align 8, !tbaa !26
  %317 = getelementptr inbounds %struct.List, ptr %315, i64 0, i32 2
  store ptr %312, ptr %317, align 8, !tbaa !35
  store ptr %315, ptr %312, align 8, !tbaa !26
  br label %322

318:                                              ; preds = %285
  %319 = getelementptr inbounds %struct.Patient, ptr %289, i64 0, i32 1
  %320 = load i32, ptr %319, align 4, !tbaa !30
  %321 = add nsw i32 %320, 1
  store i32 %321, ptr %319, align 4, !tbaa !30
  br label %322

322:                                              ; preds = %318, %addList.exit47
  %323 = load ptr, ptr %287, align 8, !tbaa !26
  %324 = icmp eq ptr %323, null
  br i1 %324, label %.loopexit.loopexit, label %283, !llvm.loop !40

.loopexit.loopexit:                               ; preds = %322
  br label %.loopexit

.loopexit.loopexit1:                              ; preds = %.preheader51
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit1, %.loopexit.loopexit, %.loopexit53
  %325 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 5
  %326 = load i64, ptr %325, align 8, !tbaa !20
  %327 = xor i64 %326, 123459876
  %328 = sdiv i64 %327, 127773
  %329 = mul nsw i64 %328, -127773
  %330 = add i64 %329, %327
  %331 = mul nsw i64 %330, 16807
  %332 = mul nsw i64 %328, -2836
  %333 = add i64 %331, %332
  %334 = xor i64 %333, 123459876
  %335 = icmp slt i64 %333, 0
  %336 = add nsw i64 %334, 2147483647
  %337 = select i1 %335, i64 %336, i64 %334
  %338 = sitofp i64 %337 to double
  %339 = fmul double %338, 0x3E00000000200000
  %340 = fptrunc double %339 to float
  %341 = fmul float %340, 0x41E0000000000000
  %342 = fptosi float %341 to i64
  store i64 %342, ptr %325, align 8, !tbaa !20
  %343 = fpext float %340 to double
  %344 = fcmp ogt double %343, 6.660000e-01
  br i1 %344, label %345, label %367

345:                                              ; preds = %.loopexit
  %346 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %347 = getelementptr inbounds %struct.Patient, ptr %346, i64 0, i32 1
  store i32 0, ptr %347, align 4, !tbaa !30
  %348 = getelementptr inbounds %struct.Patient, ptr %346, i64 0, i32 2
  store i32 0, ptr %348, align 8, !tbaa !33
  %349 = getelementptr inbounds %struct.Patient, ptr %346, i64 0, i32 3
  store ptr %0, ptr %349, align 8, !tbaa !43
  store i32 1, ptr %346, align 8, !tbaa !28
  %350 = load i32, ptr %15, align 4, !tbaa !42
  %351 = icmp sgt i32 %350, 0
  br i1 %351, label %352, label %.preheader.preheader

.preheader.preheader:                             ; preds = %345
  br label %.preheader

352:                                              ; preds = %345
  %353 = add nsw i32 %350, -1
  store i32 %353, ptr %15, align 4, !tbaa !42
  br label %354

354:                                              ; preds = %354, %352
  %355 = phi ptr [ %356, %354 ], [ %17, %352 ]
  %356 = load ptr, ptr %355, align 8, !tbaa !26
  %357 = icmp eq ptr %356, null
  br i1 %357, label %addList.exit48, label %354, !llvm.loop !36

addList.exit48:                                   ; preds = %354
  %358 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %359 = getelementptr inbounds %struct.List, ptr %358, i64 0, i32 1
  store ptr %346, ptr %359, align 8, !tbaa !27
  store ptr null, ptr %358, align 8, !tbaa !26
  %360 = getelementptr inbounds %struct.List, ptr %358, i64 0, i32 2
  store ptr %355, ptr %360, align 8, !tbaa !35
  store ptr %358, ptr %355, align 8, !tbaa !26
  store i32 3, ptr %348, align 8, !tbaa !33
  store i32 3, ptr %347, align 4, !tbaa !30
  br label %367

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %361 = phi ptr [ %362, %.preheader ], [ %16, %.preheader.preheader ]
  %362 = load ptr, ptr %361, align 8, !tbaa !26
  %363 = icmp eq ptr %362, null
  br i1 %363, label %addList.exit49, label %.preheader, !llvm.loop !36

addList.exit49:                                   ; preds = %.preheader
  %364 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %365 = getelementptr inbounds %struct.List, ptr %364, i64 0, i32 1
  store ptr %346, ptr %365, align 8, !tbaa !27
  store ptr null, ptr %364, align 8, !tbaa !26
  %366 = getelementptr inbounds %struct.List, ptr %364, i64 0, i32 2
  store ptr %361, ptr %366, align 8, !tbaa !35
  store ptr %364, ptr %361, align 8, !tbaa !26
  br label %367

367:                                              ; preds = %addList.exit49, %addList.exit48, %.loopexit, %1
  %368 = phi ptr [ null, %1 ], [ %268, %addList.exit48 ], [ %268, %addList.exit49 ], [ %268, %.loopexit ]
  ret ptr %368
}

; Function Attrs: nofree nounwind uwtable
define dso_local void @addList(ptr noundef %0, ptr noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne ptr %0, null
  tail call void @llvm.assume(i1 %3)
  br label %4

4:                                                ; preds = %4, %2
  %5 = phi ptr [ %6, %4 ], [ %0, %2 ]
  %6 = load ptr, ptr %5, align 8, !tbaa !26
  %7 = icmp eq ptr %6, null
  br i1 %7, label %8, label %4, !llvm.loop !36

8:                                                ; preds = %4
  %9 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #14
  %10 = getelementptr inbounds %struct.List, ptr %9, i64 0, i32 1
  store ptr %1, ptr %10, align 8, !tbaa !27
  store ptr null, ptr %9, align 8, !tbaa !26
  %11 = getelementptr inbounds %struct.List, ptr %9, i64 0, i32 2
  store ptr %5, ptr %11, align 8, !tbaa !35
  store ptr %9, ptr %5, align 8, !tbaa !26
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable
define dso_local void @removeList(ptr nocapture noundef readonly %0, ptr noundef readnone %1) local_unnamed_addr #10 {
  %3 = getelementptr inbounds %struct.List, ptr %0, i64 0, i32 1
  %4 = load ptr, ptr %3, align 8, !tbaa !27
  %5 = icmp eq ptr %4, %1
  br i1 %5, label %.loopexit, label %.preheader.preheader

.preheader.preheader:                             ; preds = %2
  br label %.preheader

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %6 = phi ptr [ %7, %.preheader ], [ %0, %.preheader.preheader ]
  %7 = load ptr, ptr %6, align 8, !tbaa !26
  %8 = getelementptr inbounds %struct.List, ptr %7, i64 0, i32 1
  %9 = load ptr, ptr %8, align 8, !tbaa !27
  %10 = icmp eq ptr %9, %1
  br i1 %10, label %.loopexit.loopexit, label %.preheader, !llvm.loop !34

.loopexit.loopexit:                               ; preds = %.preheader
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  %11 = phi ptr [ %0, %2 ], [ %7, %.loopexit.loopexit ]
  %12 = getelementptr inbounds %struct.List, ptr %11, i64 0, i32 2
  %13 = load ptr, ptr %12, align 8, !tbaa !35
  %14 = load ptr, ptr %11, align 8, !tbaa !26
  store ptr %14, ptr %13, align 8, !tbaa !26
  %15 = load ptr, ptr %11, align 8, !tbaa !26
  %16 = icmp eq ptr %15, null
  br i1 %16, label %19, label %17

17:                                               ; preds = %.loopexit
  %18 = getelementptr inbounds %struct.List, ptr %15, i64 0, i32 2
  store ptr %13, ptr %18, align 8, !tbaa !35
  br label %19

19:                                               ; preds = %17, %.loopexit
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #12

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree willreturn }
attributes #5 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #6 = { nofree nosync nounwind memory(read, inaccessiblemem: none) uwtable "min-legal-vector-width"="64" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { mustprogress nofree nounwind willreturn memory(write, argmem: readwrite, inaccessiblemem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { nofree nounwind uwtable "min-legal-vector-width"="64" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nofree nounwind }
attributes #10 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #13 = { nounwind }
attributes #14 = { nounwind allocsize(0) }

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
!35 = !{!17, !12, i64 16}
!36 = distinct !{!36, !32}
!37 = distinct !{!37, !32}
!38 = distinct !{!38, !32}
!39 = distinct !{!39, !32}
!40 = distinct !{!40, !32, !41}
!41 = !{!"llvm.loop.unswitch.partial.disable"}
!42 = !{!18, !6, i64 4}
!43 = !{!29, !12, i64 16}
!44 = distinct !{!44, !32}
!45 = distinct !{!45, !32}
!46 = !{!16, !12, i64 128}
!47 = !{!16, !12, i64 104}
!48 = !{!16, !12, i64 80}
