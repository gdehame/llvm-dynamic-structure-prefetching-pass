; ModuleID = 'pass.ll'
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
  %8 = tail call i64 @strtol(ptr nocapture noundef nonnull %7, ptr noundef null, i32 noundef 10) #14
  %9 = trunc i64 %8 to i32
  store i32 %9, ptr @max_level, align 4, !tbaa !5
  %10 = getelementptr inbounds ptr, ptr %1, i64 2
  %11 = load ptr, ptr %10, align 8, !tbaa !11
  %12 = tail call i64 @strtol(ptr nocapture noundef nonnull %11, ptr noundef null, i32 noundef 10) #14
  store i64 %12, ptr @max_time, align 8, !tbaa !9
  %13 = getelementptr inbounds ptr, ptr %1, i64 3
  %14 = load ptr, ptr %13, align 8, !tbaa !11
  %15 = tail call i64 @strtol(ptr nocapture noundef nonnull %14, ptr noundef null, i32 noundef 10) #14
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

common.ret1:                                      ; preds = %3, %5
  %common.ret1.op = phi ptr [ %6, %5 ], [ null, %3 ]
  ret ptr %common.ret1.op

5:                                                ; preds = %3
  %6 = tail call noalias dereferenceable_or_null(192) ptr @malloc(i64 noundef 192) #15
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
  %24 = tail call double @ldexp(double 1.000000e+00, i32 %7) #14
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

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
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
  br i1 %33, label %.loopexit, label %.preheader

.preheader:                                       ; preds = %3, %.preheader
  %34 = phi ptr [ %47, %.preheader ], [ %32, %3 ]
  %35 = phi float [ %41, %.preheader ], [ %26, %3 ]
  %36 = phi <2 x float> [ %46, %.preheader ], [ %30, %3 ]
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
  br i1 %48, label %.loopexit, label %.preheader, !llvm.loop !31

.loopexit:                                        ; preds = %.preheader, %3, %1
  %49 = phi <2 x float> [ zeroinitializer, %1 ], [ %30, %3 ], [ %46, %.preheader ]
  %50 = phi float [ 0.000000e+00, %1 ], [ %26, %3 ], [ %41, %.preheader ]
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
  br i1 %21, label %.loopexit.i, label %.preheader.i

.preheader.i:                                     ; preds = %17, %.preheader.i
  %22 = phi ptr [ %23, %.preheader.i ], [ %6, %17 ]
  %23 = load ptr, ptr %22, align 8, !tbaa !26
  %24 = getelementptr inbounds %struct.List, ptr %23, i64 0, i32 1
  %25 = load ptr, ptr %24, align 8, !tbaa !27
  %26 = icmp eq ptr %25, %12
  br i1 %26, label %.loopexit.i, label %.preheader.i, !llvm.loop !34

.loopexit.i:                                      ; preds = %.preheader.i, %17
  %27 = phi ptr [ %6, %17 ], [ %23, %.preheader.i ]
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

removeList.exit:                                  ; preds = %removeList.exit.preheader, %removeList.exit
  %35 = phi ptr [ %36, %removeList.exit ], [ %7, %removeList.exit.preheader ]
  %36 = load ptr, ptr %35, align 8, !tbaa !26
  %37 = icmp eq ptr %36, null
  br i1 %37, label %addList.exit, label %removeList.exit, !llvm.loop !36

addList.exit:                                     ; preds = %removeList.exit
  %38 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
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
  br i1 %43, label %.loopexit, label %9, !llvm.loop !37

.loopexit:                                        ; preds = %41, %2
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

12:                                               ; preds = %99, %4
  %13 = phi ptr [ null, %4 ], [ %100, %99 ]
  %14 = phi ptr [ %1, %4 ], [ %15, %99 ]
  %15 = load ptr, ptr %14, align 8, !tbaa !26
  %16 = getelementptr inbounds %struct.List, ptr %15, i64 0, i32 1
  %.not = icmp eq ptr %15, null
  br i1 %.not, label %20, label %17

17:                                               ; preds = %12
  %18 = load ptr, ptr %16, align 8, !tbaa !27
  %19 = getelementptr inbounds %struct.Patient, ptr %18, i64 0, i32 2
  tail call void @llvm.prefetch.p0(ptr nonnull %19, i32 0, i32 0, i32 1)
  br label %20

20:                                               ; preds = %17, %12
  tail call void @llvm.prefetch.p0(ptr nonnull %16, i32 0, i32 0, i32 1)
  %21 = getelementptr inbounds %struct.List, ptr %14, i64 0, i32 1
  %22 = load ptr, ptr %21, align 8, !tbaa !27
  %23 = getelementptr inbounds %struct.Patient, ptr %22, i64 0, i32 2
  %24 = load i32, ptr %23, align 8, !tbaa !33
  %25 = add nsw i32 %24, -1
  store i32 %25, ptr %23, align 8, !tbaa !33
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %99

27:                                               ; preds = %20
  %28 = load i64, ptr %6, align 8, !tbaa !20
  %29 = xor i64 %28, 123459876
  %30 = sdiv i64 %29, 127773
  %31 = mul nsw i64 %30, -127773
  %32 = add i64 %31, %29
  %33 = mul nsw i64 %32, 16807
  %34 = mul nsw i64 %30, -2836
  %35 = add i64 %33, %34
  %36 = xor i64 %35, 123459876
  %37 = icmp slt i64 %35, 0
  %38 = add nsw i64 %36, 2147483647
  %39 = select i1 %37, i64 %38, i64 %36
  %40 = sitofp i64 %39 to double
  %41 = fmul double %40, 0x3E00000000200000
  %42 = fptrunc double %41 to float
  %43 = fmul float %42, 0x41E0000000000000
  %44 = fptosi float %43 to i64
  store i64 %44, ptr %6, align 8, !tbaa !20
  %45 = load i32, ptr %5, align 8, !tbaa !19
  %46 = fpext float %42 to double
  %47 = fcmp ogt double %46, 1.000000e-01
  %48 = icmp eq i32 %45, 0
  %49 = select i1 %47, i1 true, i1 %48
  br i1 %49, label %50, label %75

50:                                               ; preds = %27
  %51 = load ptr, ptr %11, align 8, !tbaa !27
  %52 = icmp eq ptr %51, %22
  br i1 %52, label %.loopexit.i, label %.preheader.i

.preheader.i:                                     ; preds = %50, %.preheader.i
  %53 = phi ptr [ %54, %.preheader.i ], [ %8, %50 ]
  %54 = load ptr, ptr %53, align 8, !tbaa !26
  %55 = getelementptr inbounds %struct.List, ptr %54, i64 0, i32 1
  %56 = load ptr, ptr %55, align 8, !tbaa !27
  %57 = icmp eq ptr %56, %22
  br i1 %57, label %.loopexit.i, label %.preheader.i, !llvm.loop !34

.loopexit.i:                                      ; preds = %.preheader.i, %50
  %58 = phi ptr [ %8, %50 ], [ %54, %.preheader.i ]
  %59 = getelementptr inbounds %struct.List, ptr %58, i64 0, i32 2
  %60 = load ptr, ptr %59, align 8, !tbaa !35
  %61 = load ptr, ptr %58, align 8, !tbaa !26
  store ptr %61, ptr %60, align 8, !tbaa !26
  %62 = load ptr, ptr %58, align 8, !tbaa !26
  %63 = icmp eq ptr %62, null
  br i1 %63, label %removeList.exit.preheader, label %64

64:                                               ; preds = %.loopexit.i
  %65 = getelementptr inbounds %struct.List, ptr %62, i64 0, i32 2
  store ptr %60, ptr %65, align 8, !tbaa !35
  br label %removeList.exit.preheader

removeList.exit.preheader:                        ; preds = %64, %.loopexit.i
  br label %removeList.exit

removeList.exit:                                  ; preds = %removeList.exit.preheader, %removeList.exit
  %66 = phi ptr [ %67, %removeList.exit ], [ %10, %removeList.exit.preheader ]
  %67 = load ptr, ptr %66, align 8, !tbaa !26
  %68 = icmp eq ptr %67, null
  br i1 %68, label %addList.exit, label %removeList.exit, !llvm.loop !36

addList.exit:                                     ; preds = %removeList.exit
  %69 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %70 = getelementptr inbounds %struct.List, ptr %69, i64 0, i32 1
  store ptr %22, ptr %70, align 8, !tbaa !27
  store ptr null, ptr %69, align 8, !tbaa !26
  %71 = getelementptr inbounds %struct.List, ptr %69, i64 0, i32 2
  store ptr %66, ptr %71, align 8, !tbaa !35
  store ptr %69, ptr %66, align 8, !tbaa !26
  store i32 10, ptr %23, align 8, !tbaa !33
  %72 = getelementptr inbounds %struct.Patient, ptr %22, i64 0, i32 1
  %73 = load i32, ptr %72, align 4, !tbaa !30
  %74 = add nsw i32 %73, 10
  store i32 %74, ptr %72, align 4, !tbaa !30
  br label %99

75:                                               ; preds = %27
  %76 = load i32, ptr %7, align 4, !tbaa !22
  %77 = add nsw i32 %76, 1
  store i32 %77, ptr %7, align 4, !tbaa !22
  %78 = load ptr, ptr %11, align 8, !tbaa !27
  %79 = icmp eq ptr %78, %22
  br i1 %79, label %.loopexit.i3, label %.preheader.i2

.preheader.i2:                                    ; preds = %75, %.preheader.i2
  %80 = phi ptr [ %81, %.preheader.i2 ], [ %8, %75 ]
  %81 = load ptr, ptr %80, align 8, !tbaa !26
  %82 = getelementptr inbounds %struct.List, ptr %81, i64 0, i32 1
  %83 = load ptr, ptr %82, align 8, !tbaa !27
  %84 = icmp eq ptr %83, %22
  br i1 %84, label %.loopexit.i3, label %.preheader.i2, !llvm.loop !34

.loopexit.i3:                                     ; preds = %.preheader.i2, %75
  %85 = phi ptr [ %8, %75 ], [ %81, %.preheader.i2 ]
  %86 = getelementptr inbounds %struct.List, ptr %85, i64 0, i32 2
  %87 = load ptr, ptr %86, align 8, !tbaa !35
  %88 = load ptr, ptr %85, align 8, !tbaa !26
  store ptr %88, ptr %87, align 8, !tbaa !26
  %89 = load ptr, ptr %85, align 8, !tbaa !26
  %90 = icmp eq ptr %89, null
  br i1 %90, label %removeList.exit4.preheader, label %91

91:                                               ; preds = %.loopexit.i3
  %92 = getelementptr inbounds %struct.List, ptr %89, i64 0, i32 2
  store ptr %87, ptr %92, align 8, !tbaa !35
  br label %removeList.exit4.preheader

removeList.exit4.preheader:                       ; preds = %91, %.loopexit.i3
  br label %removeList.exit4

removeList.exit4:                                 ; preds = %removeList.exit4.preheader, %removeList.exit4
  %93 = phi ptr [ %94, %removeList.exit4 ], [ %9, %removeList.exit4.preheader ]
  %94 = load ptr, ptr %93, align 8, !tbaa !26
  %95 = icmp eq ptr %94, null
  br i1 %95, label %addList.exit5, label %removeList.exit4, !llvm.loop !36

addList.exit5:                                    ; preds = %removeList.exit4
  %96 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %97 = getelementptr inbounds %struct.List, ptr %96, i64 0, i32 1
  store ptr %22, ptr %97, align 8, !tbaa !27
  store ptr null, ptr %96, align 8, !tbaa !26
  %98 = getelementptr inbounds %struct.List, ptr %96, i64 0, i32 2
  store ptr %93, ptr %98, align 8, !tbaa !35
  store ptr %96, ptr %93, align 8, !tbaa !26
  br label %99

99:                                               ; preds = %addList.exit5, %addList.exit, %20
  %100 = phi ptr [ %13, %addList.exit ], [ %9, %addList.exit5 ], [ %13, %20 ]
  br i1 %.not, label %.loopexit, label %12, !llvm.loop !38

.loopexit:                                        ; preds = %99, %2
  %101 = phi ptr [ null, %2 ], [ %100, %99 ]
  ret ptr %101
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
  br i1 %9, label %.preheader, label %.preheader4

.preheader:                                       ; preds = %4
  %10 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 3, i32 1
  br label %19

.preheader4:                                      ; preds = %4, %.preheader4
  %11 = phi ptr [ %17, %.preheader4 ], [ %1, %4 ]
  %12 = getelementptr inbounds %struct.List, ptr %11, i64 0, i32 1
  %13 = load ptr, ptr %12, align 8, !tbaa !27
  %14 = getelementptr inbounds %struct.Patient, ptr %13, i64 0, i32 1
  %15 = load i32, ptr %14, align 4, !tbaa !30
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %14, align 4, !tbaa !30
  %17 = load ptr, ptr %11, align 8, !tbaa !26
  %18 = icmp eq ptr %17, null
  br i1 %18, label %.loopexit, label %.preheader4, !llvm.loop !39

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
  br i1 %32, label %.loopexit.i, label %.preheader.i

.preheader.i:                                     ; preds = %25, %.preheader.i
  %33 = phi ptr [ %34, %.preheader.i ], [ %6, %25 ]
  %34 = load ptr, ptr %33, align 8, !tbaa !26
  %35 = getelementptr inbounds %struct.List, ptr %34, i64 0, i32 1
  %36 = load ptr, ptr %35, align 8, !tbaa !27
  %37 = icmp eq ptr %36, %23
  br i1 %37, label %.loopexit.i, label %.preheader.i, !llvm.loop !34

.loopexit.i:                                      ; preds = %.preheader.i, %25
  %38 = phi ptr [ %6, %25 ], [ %34, %.preheader.i ]
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

removeList.exit:                                  ; preds = %removeList.exit.preheader, %removeList.exit
  %46 = phi ptr [ %47, %removeList.exit ], [ %7, %removeList.exit.preheader ]
  %47 = load ptr, ptr %46, align 8, !tbaa !26
  %48 = icmp eq ptr %47, null
  br i1 %48, label %addList.exit, label %removeList.exit, !llvm.loop !36

addList.exit:                                     ; preds = %removeList.exit
  %49 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
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
  %57 = phi i32 [ 0, %52 ], [ %26, %addList.exit ]
  %58 = load ptr, ptr %21, align 8, !tbaa !26
  %59 = icmp eq ptr %58, null
  br i1 %59, label %.loopexit, label %19, !llvm.loop !40

.loopexit:                                        ; preds = %.preheader4, %56, %2
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
  %15 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
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
  %28 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
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
  %23 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
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
  %8 = tail call i64 @strtol(ptr nocapture noundef nonnull %7, ptr noundef null, i32 noundef 10) #14
  %9 = trunc i64 %8 to i32
  store i32 %9, ptr @max_level, align 4, !tbaa !5
  %10 = getelementptr inbounds ptr, ptr %1, i64 2
  %11 = load ptr, ptr %10, align 8, !tbaa !11
  %12 = tail call i64 @strtol(ptr nocapture noundef nonnull %11, ptr noundef null, i32 noundef 10) #14
  store i64 %12, ptr @max_time, align 8, !tbaa !9
  %13 = getelementptr inbounds ptr, ptr %1, i64 3
  %14 = load ptr, ptr %13, align 8, !tbaa !11
  %15 = tail call i64 @strtol(ptr nocapture noundef nonnull %14, ptr noundef null, i32 noundef 10) #14
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
  br i1 %29, label %.preheader, label %.loopexit

.preheader:                                       ; preds = %dealwithargs.exit, %36
  %30 = phi i64 [ %38, %36 ], [ 0, %dealwithargs.exit ]
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
  br i1 %40, label %.preheader, label %.loopexit, !llvm.loop !44

.loopexit:                                        ; preds = %36, %dealwithargs.exit
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
  br i1 %2, label %384, label %3

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
  %24 = phi i32 [ %56, %removeList.exit ], [ %.promoted, %.preheader64 ]
  %25 = phi ptr [ %26, %removeList.exit ], [ %20, %.preheader64 ]
  %26 = load ptr, ptr %25, align 8, !tbaa !26
  %27 = getelementptr inbounds %struct.List, ptr %26, i64 0, i32 1
  %.not = icmp eq ptr %26, null
  br i1 %.not, label %30, label %28

28:                                               ; preds = %23
  %29 = load ptr, ptr %27, align 8, !tbaa !27
  tail call void @llvm.prefetch.p0(ptr %29, i32 0, i32 0, i32 1)
  br label %30

30:                                               ; preds = %28, %23
  tail call void @llvm.prefetch.p0(ptr nonnull %27, i32 0, i32 0, i32 1)
  %31 = getelementptr inbounds %struct.List, ptr %25, i64 0, i32 1
  %32 = load ptr, ptr %31, align 8, !tbaa !27
  %33 = load i32, ptr %32, align 8, !tbaa !28
  %34 = add nsw i32 %33, 1
  store i32 %34, ptr %32, align 8, !tbaa !28
  %35 = icmp sgt i32 %24, 0
  br i1 %35, label %36, label %.preheader63

36:                                               ; preds = %30
  %37 = add nsw i32 %24, -1
  store i32 %37, ptr %15, align 4, !tbaa !42
  br label %38

38:                                               ; preds = %38, %36
  %39 = phi ptr [ %40, %38 ], [ %17, %36 ]
  %40 = load ptr, ptr %39, align 8, !tbaa !26
  %41 = icmp eq ptr %40, null
  br i1 %41, label %addList.exit, label %38, !llvm.loop !36

addList.exit:                                     ; preds = %38
  %42 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %43 = getelementptr inbounds %struct.List, ptr %42, i64 0, i32 1
  store ptr %32, ptr %43, align 8, !tbaa !27
  store ptr null, ptr %42, align 8, !tbaa !26
  %44 = getelementptr inbounds %struct.List, ptr %42, i64 0, i32 2
  store ptr %39, ptr %44, align 8, !tbaa !35
  store ptr %42, ptr %39, align 8, !tbaa !26
  %45 = getelementptr inbounds %struct.Patient, ptr %32, i64 0, i32 2
  store i32 3, ptr %45, align 8, !tbaa !33
  %46 = getelementptr inbounds %struct.Patient, ptr %32, i64 0, i32 1
  %47 = load i32, ptr %46, align 4, !tbaa !30
  %48 = add nsw i32 %47, 3
  store i32 %48, ptr %46, align 4, !tbaa !30
  br label %55

.preheader63:                                     ; preds = %30, %.preheader63
  %49 = phi ptr [ %50, %.preheader63 ], [ %16, %30 ]
  %50 = load ptr, ptr %49, align 8, !tbaa !26
  %51 = icmp eq ptr %50, null
  br i1 %51, label %addList.exit24, label %.preheader63, !llvm.loop !36

addList.exit24:                                   ; preds = %.preheader63
  %52 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %53 = getelementptr inbounds %struct.List, ptr %52, i64 0, i32 1
  store ptr %32, ptr %53, align 8, !tbaa !27
  store ptr null, ptr %52, align 8, !tbaa !26
  %54 = getelementptr inbounds %struct.List, ptr %52, i64 0, i32 2
  store ptr %49, ptr %54, align 8, !tbaa !35
  store ptr %52, ptr %49, align 8, !tbaa !26
  br label %55

55:                                               ; preds = %addList.exit24, %addList.exit
  %56 = phi i32 [ %24, %addList.exit24 ], [ %37, %addList.exit ]
  %57 = load ptr, ptr %31, align 8, !tbaa !27
  %58 = load ptr, ptr %22, align 8, !tbaa !27
  %59 = icmp eq ptr %58, %57
  br i1 %59, label %.loopexit.i, label %.preheader.i

.preheader.i:                                     ; preds = %55, %.preheader.i
  %60 = phi ptr [ %61, %.preheader.i ], [ %6, %55 ]
  %61 = load ptr, ptr %60, align 8, !tbaa !26
  %62 = getelementptr inbounds %struct.List, ptr %61, i64 0, i32 1
  %63 = load ptr, ptr %62, align 8, !tbaa !27
  %64 = icmp eq ptr %63, %57
  br i1 %64, label %.loopexit.i, label %.preheader.i, !llvm.loop !34

.loopexit.i:                                      ; preds = %.preheader.i, %55
  %65 = phi ptr [ %6, %55 ], [ %61, %.preheader.i ]
  %66 = getelementptr inbounds %struct.List, ptr %65, i64 0, i32 2
  %67 = load ptr, ptr %66, align 8, !tbaa !35
  %68 = load ptr, ptr %65, align 8, !tbaa !26
  store ptr %68, ptr %67, align 8, !tbaa !26
  %69 = load ptr, ptr %65, align 8, !tbaa !26
  %70 = icmp eq ptr %69, null
  br i1 %70, label %removeList.exit, label %71

71:                                               ; preds = %.loopexit.i
  %72 = getelementptr inbounds %struct.List, ptr %69, i64 0, i32 2
  store ptr %67, ptr %72, align 8, !tbaa !35
  br label %removeList.exit

removeList.exit:                                  ; preds = %71, %.loopexit.i
  br i1 %.not, label %.loopexit65, label %23, !llvm.loop !45

.loopexit65:                                      ; preds = %removeList.exit, %19, %3
  %73 = icmp eq ptr %9, null
  br i1 %73, label %.loopexit62, label %74

74:                                               ; preds = %.loopexit65
  %75 = load ptr, ptr %9, align 8, !tbaa !26
  %76 = icmp eq ptr %75, null
  br i1 %76, label %.loopexit62, label %.preheader61

.preheader61:                                     ; preds = %74
  %77 = getelementptr inbounds %struct.List, ptr %9, i64 0, i32 1
  %.promoted83 = load i32, ptr %15, align 4, !tbaa !42
  br label %78

78:                                               ; preds = %removeList.exit29, %.preheader61
  %79 = phi i32 [ %111, %removeList.exit29 ], [ %.promoted83, %.preheader61 ]
  %80 = phi ptr [ %81, %removeList.exit29 ], [ %75, %.preheader61 ]
  %81 = load ptr, ptr %80, align 8, !tbaa !26
  %82 = getelementptr inbounds %struct.List, ptr %81, i64 0, i32 1
  %.not30 = icmp eq ptr %81, null
  br i1 %.not30, label %85, label %83

83:                                               ; preds = %78
  %84 = load ptr, ptr %82, align 8, !tbaa !27
  tail call void @llvm.prefetch.p0(ptr %84, i32 0, i32 0, i32 1)
  br label %85

85:                                               ; preds = %83, %78
  tail call void @llvm.prefetch.p0(ptr nonnull %82, i32 0, i32 0, i32 1)
  %86 = getelementptr inbounds %struct.List, ptr %80, i64 0, i32 1
  %87 = load ptr, ptr %86, align 8, !tbaa !27
  %88 = load i32, ptr %87, align 8, !tbaa !28
  %89 = add nsw i32 %88, 1
  store i32 %89, ptr %87, align 8, !tbaa !28
  %90 = icmp sgt i32 %79, 0
  br i1 %90, label %97, label %.preheader60

.preheader60:                                     ; preds = %85, %.preheader60
  %91 = phi ptr [ %92, %.preheader60 ], [ %16, %85 ]
  %92 = load ptr, ptr %91, align 8, !tbaa !26
  %93 = icmp eq ptr %92, null
  br i1 %93, label %addList.exit25, label %.preheader60, !llvm.loop !36

addList.exit25:                                   ; preds = %.preheader60
  %94 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %95 = getelementptr inbounds %struct.List, ptr %94, i64 0, i32 1
  store ptr %87, ptr %95, align 8, !tbaa !27
  store ptr null, ptr %94, align 8, !tbaa !26
  %96 = getelementptr inbounds %struct.List, ptr %94, i64 0, i32 2
  store ptr %91, ptr %96, align 8, !tbaa !35
  store ptr %94, ptr %91, align 8, !tbaa !26
  br label %110

97:                                               ; preds = %85
  %98 = add nsw i32 %79, -1
  store i32 %98, ptr %15, align 4, !tbaa !42
  br label %99

99:                                               ; preds = %99, %97
  %100 = phi ptr [ %101, %99 ], [ %17, %97 ]
  %101 = load ptr, ptr %100, align 8, !tbaa !26
  %102 = icmp eq ptr %101, null
  br i1 %102, label %addList.exit26, label %99, !llvm.loop !36

addList.exit26:                                   ; preds = %99
  %103 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %104 = getelementptr inbounds %struct.List, ptr %103, i64 0, i32 1
  store ptr %87, ptr %104, align 8, !tbaa !27
  store ptr null, ptr %103, align 8, !tbaa !26
  %105 = getelementptr inbounds %struct.List, ptr %103, i64 0, i32 2
  store ptr %100, ptr %105, align 8, !tbaa !35
  store ptr %103, ptr %100, align 8, !tbaa !26
  %106 = getelementptr inbounds %struct.Patient, ptr %87, i64 0, i32 2
  store i32 3, ptr %106, align 8, !tbaa !33
  %107 = getelementptr inbounds %struct.Patient, ptr %87, i64 0, i32 1
  %108 = load i32, ptr %107, align 4, !tbaa !30
  %109 = add nsw i32 %108, 3
  store i32 %109, ptr %107, align 4, !tbaa !30
  br label %110

110:                                              ; preds = %addList.exit26, %addList.exit25
  %111 = phi i32 [ %98, %addList.exit26 ], [ %79, %addList.exit25 ]
  %112 = load ptr, ptr %86, align 8, !tbaa !27
  %113 = load ptr, ptr %77, align 8, !tbaa !27
  %114 = icmp eq ptr %113, %112
  br i1 %114, label %.loopexit.i28, label %.preheader.i27

.preheader.i27:                                   ; preds = %110, %.preheader.i27
  %115 = phi ptr [ %116, %.preheader.i27 ], [ %9, %110 ]
  %116 = load ptr, ptr %115, align 8, !tbaa !26
  %117 = getelementptr inbounds %struct.List, ptr %116, i64 0, i32 1
  %118 = load ptr, ptr %117, align 8, !tbaa !27
  %119 = icmp eq ptr %118, %112
  br i1 %119, label %.loopexit.i28, label %.preheader.i27, !llvm.loop !34

.loopexit.i28:                                    ; preds = %.preheader.i27, %110
  %120 = phi ptr [ %9, %110 ], [ %116, %.preheader.i27 ]
  %121 = getelementptr inbounds %struct.List, ptr %120, i64 0, i32 2
  %122 = load ptr, ptr %121, align 8, !tbaa !35
  %123 = load ptr, ptr %120, align 8, !tbaa !26
  store ptr %123, ptr %122, align 8, !tbaa !26
  %124 = load ptr, ptr %120, align 8, !tbaa !26
  %125 = icmp eq ptr %124, null
  br i1 %125, label %removeList.exit29, label %126

126:                                              ; preds = %.loopexit.i28
  %127 = getelementptr inbounds %struct.List, ptr %124, i64 0, i32 2
  store ptr %122, ptr %127, align 8, !tbaa !35
  br label %removeList.exit29

removeList.exit29:                                ; preds = %126, %.loopexit.i28
  br i1 %.not30, label %.loopexit62, label %78, !llvm.loop !45

.loopexit62:                                      ; preds = %removeList.exit29, %74, %.loopexit65
  %128 = icmp eq ptr %12, null
  br i1 %128, label %.loopexit59, label %129

129:                                              ; preds = %.loopexit62
  %130 = load ptr, ptr %12, align 8, !tbaa !26
  %131 = icmp eq ptr %130, null
  br i1 %131, label %.loopexit59, label %.preheader58

.preheader58:                                     ; preds = %129
  %132 = getelementptr inbounds %struct.List, ptr %12, i64 0, i32 1
  %.promoted84 = load i32, ptr %15, align 4, !tbaa !42
  br label %133

133:                                              ; preds = %removeList.exit34, %.preheader58
  %134 = phi i32 [ %166, %removeList.exit34 ], [ %.promoted84, %.preheader58 ]
  %135 = phi ptr [ %136, %removeList.exit34 ], [ %130, %.preheader58 ]
  %136 = load ptr, ptr %135, align 8, !tbaa !26
  %137 = getelementptr inbounds %struct.List, ptr %136, i64 0, i32 1
  %.not31 = icmp eq ptr %136, null
  br i1 %.not31, label %140, label %138

138:                                              ; preds = %133
  %139 = load ptr, ptr %137, align 8, !tbaa !27
  tail call void @llvm.prefetch.p0(ptr %139, i32 0, i32 0, i32 1)
  br label %140

140:                                              ; preds = %138, %133
  tail call void @llvm.prefetch.p0(ptr nonnull %137, i32 0, i32 0, i32 1)
  %141 = getelementptr inbounds %struct.List, ptr %135, i64 0, i32 1
  %142 = load ptr, ptr %141, align 8, !tbaa !27
  %143 = load i32, ptr %142, align 8, !tbaa !28
  %144 = add nsw i32 %143, 1
  store i32 %144, ptr %142, align 8, !tbaa !28
  %145 = icmp sgt i32 %134, 0
  br i1 %145, label %152, label %.preheader57

.preheader57:                                     ; preds = %140, %.preheader57
  %146 = phi ptr [ %147, %.preheader57 ], [ %16, %140 ]
  %147 = load ptr, ptr %146, align 8, !tbaa !26
  %148 = icmp eq ptr %147, null
  br i1 %148, label %addList.exit30, label %.preheader57, !llvm.loop !36

addList.exit30:                                   ; preds = %.preheader57
  %149 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %150 = getelementptr inbounds %struct.List, ptr %149, i64 0, i32 1
  store ptr %142, ptr %150, align 8, !tbaa !27
  store ptr null, ptr %149, align 8, !tbaa !26
  %151 = getelementptr inbounds %struct.List, ptr %149, i64 0, i32 2
  store ptr %146, ptr %151, align 8, !tbaa !35
  store ptr %149, ptr %146, align 8, !tbaa !26
  br label %165

152:                                              ; preds = %140
  %153 = add nsw i32 %134, -1
  store i32 %153, ptr %15, align 4, !tbaa !42
  br label %154

154:                                              ; preds = %154, %152
  %155 = phi ptr [ %156, %154 ], [ %17, %152 ]
  %156 = load ptr, ptr %155, align 8, !tbaa !26
  %157 = icmp eq ptr %156, null
  br i1 %157, label %addList.exit31, label %154, !llvm.loop !36

addList.exit31:                                   ; preds = %154
  %158 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %159 = getelementptr inbounds %struct.List, ptr %158, i64 0, i32 1
  store ptr %142, ptr %159, align 8, !tbaa !27
  store ptr null, ptr %158, align 8, !tbaa !26
  %160 = getelementptr inbounds %struct.List, ptr %158, i64 0, i32 2
  store ptr %155, ptr %160, align 8, !tbaa !35
  store ptr %158, ptr %155, align 8, !tbaa !26
  %161 = getelementptr inbounds %struct.Patient, ptr %142, i64 0, i32 2
  store i32 3, ptr %161, align 8, !tbaa !33
  %162 = getelementptr inbounds %struct.Patient, ptr %142, i64 0, i32 1
  %163 = load i32, ptr %162, align 4, !tbaa !30
  %164 = add nsw i32 %163, 3
  store i32 %164, ptr %162, align 4, !tbaa !30
  br label %165

165:                                              ; preds = %addList.exit31, %addList.exit30
  %166 = phi i32 [ %153, %addList.exit31 ], [ %134, %addList.exit30 ]
  %167 = load ptr, ptr %141, align 8, !tbaa !27
  %168 = load ptr, ptr %132, align 8, !tbaa !27
  %169 = icmp eq ptr %168, %167
  br i1 %169, label %.loopexit.i33, label %.preheader.i32

.preheader.i32:                                   ; preds = %165, %.preheader.i32
  %170 = phi ptr [ %171, %.preheader.i32 ], [ %12, %165 ]
  %171 = load ptr, ptr %170, align 8, !tbaa !26
  %172 = getelementptr inbounds %struct.List, ptr %171, i64 0, i32 1
  %173 = load ptr, ptr %172, align 8, !tbaa !27
  %174 = icmp eq ptr %173, %167
  br i1 %174, label %.loopexit.i33, label %.preheader.i32, !llvm.loop !34

.loopexit.i33:                                    ; preds = %.preheader.i32, %165
  %175 = phi ptr [ %12, %165 ], [ %171, %.preheader.i32 ]
  %176 = getelementptr inbounds %struct.List, ptr %175, i64 0, i32 2
  %177 = load ptr, ptr %176, align 8, !tbaa !35
  %178 = load ptr, ptr %175, align 8, !tbaa !26
  store ptr %178, ptr %177, align 8, !tbaa !26
  %179 = load ptr, ptr %175, align 8, !tbaa !26
  %180 = icmp eq ptr %179, null
  br i1 %180, label %removeList.exit34, label %181

181:                                              ; preds = %.loopexit.i33
  %182 = getelementptr inbounds %struct.List, ptr %179, i64 0, i32 2
  store ptr %177, ptr %182, align 8, !tbaa !35
  br label %removeList.exit34

removeList.exit34:                                ; preds = %181, %.loopexit.i33
  br i1 %.not31, label %.loopexit59, label %133, !llvm.loop !45

.loopexit59:                                      ; preds = %removeList.exit34, %129, %.loopexit62
  %183 = icmp eq ptr %14, null
  br i1 %183, label %.loopexit56, label %184

184:                                              ; preds = %.loopexit59
  %185 = load ptr, ptr %14, align 8, !tbaa !26
  %186 = icmp eq ptr %185, null
  br i1 %186, label %.loopexit56, label %.preheader55

.preheader55:                                     ; preds = %184
  %187 = getelementptr inbounds %struct.List, ptr %14, i64 0, i32 1
  %.promoted85 = load i32, ptr %15, align 4, !tbaa !42
  br label %188

188:                                              ; preds = %removeList.exit39, %.preheader55
  %189 = phi i32 [ %221, %removeList.exit39 ], [ %.promoted85, %.preheader55 ]
  %190 = phi ptr [ %191, %removeList.exit39 ], [ %185, %.preheader55 ]
  %191 = load ptr, ptr %190, align 8, !tbaa !26
  %192 = getelementptr inbounds %struct.List, ptr %191, i64 0, i32 1
  %.not32 = icmp eq ptr %191, null
  br i1 %.not32, label %195, label %193

193:                                              ; preds = %188
  %194 = load ptr, ptr %192, align 8, !tbaa !27
  tail call void @llvm.prefetch.p0(ptr %194, i32 0, i32 0, i32 1)
  br label %195

195:                                              ; preds = %193, %188
  tail call void @llvm.prefetch.p0(ptr nonnull %192, i32 0, i32 0, i32 1)
  %196 = getelementptr inbounds %struct.List, ptr %190, i64 0, i32 1
  %197 = load ptr, ptr %196, align 8, !tbaa !27
  %198 = load i32, ptr %197, align 8, !tbaa !28
  %199 = add nsw i32 %198, 1
  store i32 %199, ptr %197, align 8, !tbaa !28
  %200 = icmp sgt i32 %189, 0
  br i1 %200, label %207, label %.preheader54

.preheader54:                                     ; preds = %195, %.preheader54
  %201 = phi ptr [ %202, %.preheader54 ], [ %16, %195 ]
  %202 = load ptr, ptr %201, align 8, !tbaa !26
  %203 = icmp eq ptr %202, null
  br i1 %203, label %addList.exit35, label %.preheader54, !llvm.loop !36

addList.exit35:                                   ; preds = %.preheader54
  %204 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %205 = getelementptr inbounds %struct.List, ptr %204, i64 0, i32 1
  store ptr %197, ptr %205, align 8, !tbaa !27
  store ptr null, ptr %204, align 8, !tbaa !26
  %206 = getelementptr inbounds %struct.List, ptr %204, i64 0, i32 2
  store ptr %201, ptr %206, align 8, !tbaa !35
  store ptr %204, ptr %201, align 8, !tbaa !26
  br label %220

207:                                              ; preds = %195
  %208 = add nsw i32 %189, -1
  store i32 %208, ptr %15, align 4, !tbaa !42
  br label %209

209:                                              ; preds = %209, %207
  %210 = phi ptr [ %211, %209 ], [ %17, %207 ]
  %211 = load ptr, ptr %210, align 8, !tbaa !26
  %212 = icmp eq ptr %211, null
  br i1 %212, label %addList.exit36, label %209, !llvm.loop !36

addList.exit36:                                   ; preds = %209
  %213 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %214 = getelementptr inbounds %struct.List, ptr %213, i64 0, i32 1
  store ptr %197, ptr %214, align 8, !tbaa !27
  store ptr null, ptr %213, align 8, !tbaa !26
  %215 = getelementptr inbounds %struct.List, ptr %213, i64 0, i32 2
  store ptr %210, ptr %215, align 8, !tbaa !35
  store ptr %213, ptr %210, align 8, !tbaa !26
  %216 = getelementptr inbounds %struct.Patient, ptr %197, i64 0, i32 2
  store i32 3, ptr %216, align 8, !tbaa !33
  %217 = getelementptr inbounds %struct.Patient, ptr %197, i64 0, i32 1
  %218 = load i32, ptr %217, align 4, !tbaa !30
  %219 = add nsw i32 %218, 3
  store i32 %219, ptr %217, align 4, !tbaa !30
  br label %220

220:                                              ; preds = %addList.exit36, %addList.exit35
  %221 = phi i32 [ %208, %addList.exit36 ], [ %189, %addList.exit35 ]
  %222 = load ptr, ptr %196, align 8, !tbaa !27
  %223 = load ptr, ptr %187, align 8, !tbaa !27
  %224 = icmp eq ptr %223, %222
  br i1 %224, label %.loopexit.i38, label %.preheader.i37

.preheader.i37:                                   ; preds = %220, %.preheader.i37
  %225 = phi ptr [ %226, %.preheader.i37 ], [ %14, %220 ]
  %226 = load ptr, ptr %225, align 8, !tbaa !26
  %227 = getelementptr inbounds %struct.List, ptr %226, i64 0, i32 1
  %228 = load ptr, ptr %227, align 8, !tbaa !27
  %229 = icmp eq ptr %228, %222
  br i1 %229, label %.loopexit.i38, label %.preheader.i37, !llvm.loop !34

.loopexit.i38:                                    ; preds = %.preheader.i37, %220
  %230 = phi ptr [ %14, %220 ], [ %226, %.preheader.i37 ]
  %231 = getelementptr inbounds %struct.List, ptr %230, i64 0, i32 2
  %232 = load ptr, ptr %231, align 8, !tbaa !35
  %233 = load ptr, ptr %230, align 8, !tbaa !26
  store ptr %233, ptr %232, align 8, !tbaa !26
  %234 = load ptr, ptr %230, align 8, !tbaa !26
  %235 = icmp eq ptr %234, null
  br i1 %235, label %removeList.exit39, label %236

236:                                              ; preds = %.loopexit.i38
  %237 = getelementptr inbounds %struct.List, ptr %234, i64 0, i32 2
  store ptr %232, ptr %237, align 8, !tbaa !35
  br label %removeList.exit39

removeList.exit39:                                ; preds = %236, %.loopexit.i38
  br i1 %.not32, label %.loopexit56, label %188, !llvm.loop !45

.loopexit56:                                      ; preds = %removeList.exit39, %184, %.loopexit59
  %238 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5
  %239 = load ptr, ptr %238, align 8, !tbaa !46
  %240 = icmp eq ptr %239, null
  br i1 %240, label %.loopexit53, label %241

241:                                              ; preds = %.loopexit56
  %242 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 2
  %243 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 5, i32 1
  br label %244

244:                                              ; preds = %282, %241
  %245 = phi ptr [ %239, %241 ], [ %246, %282 ]
  %246 = load ptr, ptr %245, align 8, !tbaa !26
  %247 = getelementptr inbounds %struct.List, ptr %246, i64 0, i32 1
  %.not33 = icmp eq ptr %246, null
  br i1 %.not33, label %251, label %248

248:                                              ; preds = %244
  %249 = load ptr, ptr %247, align 8, !tbaa !27
  %250 = getelementptr inbounds %struct.Patient, ptr %249, i64 0, i32 2
  tail call void @llvm.prefetch.p0(ptr nonnull %250, i32 0, i32 0, i32 1)
  br label %251

251:                                              ; preds = %248, %244
  tail call void @llvm.prefetch.p0(ptr nonnull %247, i32 0, i32 0, i32 1)
  %252 = getelementptr inbounds %struct.List, ptr %245, i64 0, i32 1
  %253 = load ptr, ptr %252, align 8, !tbaa !27
  %254 = getelementptr inbounds %struct.Patient, ptr %253, i64 0, i32 2
  %255 = load i32, ptr %254, align 8, !tbaa !33
  %256 = add nsw i32 %255, -1
  store i32 %256, ptr %254, align 8, !tbaa !33
  %257 = icmp eq i32 %256, 0
  br i1 %257, label %258, label %282

258:                                              ; preds = %251
  %259 = load i32, ptr %15, align 4, !tbaa !22
  %260 = add nsw i32 %259, 1
  store i32 %260, ptr %15, align 4, !tbaa !22
  %261 = load ptr, ptr %243, align 8, !tbaa !27
  %262 = icmp eq ptr %261, %253
  br i1 %262, label %.loopexit.i41, label %.preheader.i40

.preheader.i40:                                   ; preds = %258, %.preheader.i40
  %263 = phi ptr [ %264, %.preheader.i40 ], [ %238, %258 ]
  %264 = load ptr, ptr %263, align 8, !tbaa !26
  %265 = getelementptr inbounds %struct.List, ptr %264, i64 0, i32 1
  %266 = load ptr, ptr %265, align 8, !tbaa !27
  %267 = icmp eq ptr %266, %253
  br i1 %267, label %.loopexit.i41, label %.preheader.i40, !llvm.loop !34

.loopexit.i41:                                    ; preds = %.preheader.i40, %258
  %268 = phi ptr [ %238, %258 ], [ %264, %.preheader.i40 ]
  %269 = getelementptr inbounds %struct.List, ptr %268, i64 0, i32 2
  %270 = load ptr, ptr %269, align 8, !tbaa !35
  %271 = load ptr, ptr %268, align 8, !tbaa !26
  store ptr %271, ptr %270, align 8, !tbaa !26
  %272 = load ptr, ptr %268, align 8, !tbaa !26
  %273 = icmp eq ptr %272, null
  br i1 %273, label %removeList.exit42.preheader, label %274

274:                                              ; preds = %.loopexit.i41
  %275 = getelementptr inbounds %struct.List, ptr %272, i64 0, i32 2
  store ptr %270, ptr %275, align 8, !tbaa !35
  br label %removeList.exit42.preheader

removeList.exit42.preheader:                      ; preds = %274, %.loopexit.i41
  br label %removeList.exit42

removeList.exit42:                                ; preds = %removeList.exit42.preheader, %removeList.exit42
  %276 = phi ptr [ %277, %removeList.exit42 ], [ %242, %removeList.exit42.preheader ]
  %277 = load ptr, ptr %276, align 8, !tbaa !26
  %278 = icmp eq ptr %277, null
  br i1 %278, label %addList.exit43, label %removeList.exit42, !llvm.loop !36

addList.exit43:                                   ; preds = %removeList.exit42
  %279 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %280 = getelementptr inbounds %struct.List, ptr %279, i64 0, i32 1
  store ptr %253, ptr %280, align 8, !tbaa !27
  store ptr null, ptr %279, align 8, !tbaa !26
  %281 = getelementptr inbounds %struct.List, ptr %279, i64 0, i32 2
  store ptr %276, ptr %281, align 8, !tbaa !35
  store ptr %279, ptr %276, align 8, !tbaa !26
  br label %282

282:                                              ; preds = %addList.exit43, %251
  br i1 %.not33, label %.loopexit53, label %244, !llvm.loop !37

.loopexit53:                                      ; preds = %282, %.loopexit56
  %283 = load ptr, ptr %17, align 8, !tbaa !47
  %284 = tail call ptr @check_patients_assess(ptr noundef nonnull %0, ptr noundef %283)
  %285 = load ptr, ptr %16, align 8, !tbaa !48
  %286 = icmp eq ptr %285, null
  br i1 %286, label %.loopexit, label %287

287:                                              ; preds = %.loopexit53
  %288 = load i32, ptr %15, align 4, !tbaa !22
  %289 = icmp sgt i32 %288, 0
  br i1 %289, label %.preheader50, label %.preheader51

.preheader50:                                     ; preds = %287
  %290 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 3, i32 3, i32 1
  br label %301

.preheader51:                                     ; preds = %287, %.preheader51
  %291 = phi ptr [ %297, %.preheader51 ], [ %285, %287 ]
  %292 = getelementptr inbounds %struct.List, ptr %291, i64 0, i32 1
  %293 = load ptr, ptr %292, align 8, !tbaa !27
  %294 = getelementptr inbounds %struct.Patient, ptr %293, i64 0, i32 1
  %295 = load i32, ptr %294, align 4, !tbaa !30
  %296 = add nsw i32 %295, 1
  store i32 %296, ptr %294, align 4, !tbaa !30
  %297 = load ptr, ptr %291, align 8, !tbaa !26
  %298 = icmp eq ptr %297, null
  br i1 %298, label %.loopexit, label %.preheader51, !llvm.loop !39

299:                                              ; preds = %340
  %300 = load i32, ptr %15, align 4, !tbaa !22
  br label %301

301:                                              ; preds = %299, %.preheader50
  %302 = phi i32 [ %300, %299 ], [ %288, %.preheader50 ]
  %303 = phi ptr [ %304, %299 ], [ %285, %.preheader50 ]
  %304 = load ptr, ptr %303, align 8, !tbaa !26
  %305 = getelementptr inbounds %struct.List, ptr %304, i64 0, i32 1
  tail call void @llvm.prefetch.p0(ptr nonnull %305, i32 0, i32 0, i32 1)
  %306 = getelementptr inbounds %struct.List, ptr %303, i64 0, i32 1
  %307 = load ptr, ptr %306, align 8, !tbaa !27
  %308 = icmp sgt i32 %302, 0
  br i1 %308, label %309, label %336

309:                                              ; preds = %301
  %310 = add nsw i32 %302, -1
  store i32 %310, ptr %15, align 4, !tbaa !22
  %311 = getelementptr inbounds %struct.Patient, ptr %307, i64 0, i32 2
  store i32 3, ptr %311, align 8, !tbaa !33
  %312 = getelementptr inbounds %struct.Patient, ptr %307, i64 0, i32 1
  %313 = load i32, ptr %312, align 4, !tbaa !30
  %314 = add nsw i32 %313, 3
  store i32 %314, ptr %312, align 4, !tbaa !30
  %315 = load ptr, ptr %290, align 8, !tbaa !27
  %316 = icmp eq ptr %315, %307
  br i1 %316, label %.loopexit.i45, label %.preheader.i44

.preheader.i44:                                   ; preds = %309, %.preheader.i44
  %317 = phi ptr [ %318, %.preheader.i44 ], [ %16, %309 ]
  %318 = load ptr, ptr %317, align 8, !tbaa !26
  %319 = getelementptr inbounds %struct.List, ptr %318, i64 0, i32 1
  %320 = load ptr, ptr %319, align 8, !tbaa !27
  %321 = icmp eq ptr %320, %307
  br i1 %321, label %.loopexit.i45, label %.preheader.i44, !llvm.loop !34

.loopexit.i45:                                    ; preds = %.preheader.i44, %309
  %322 = phi ptr [ %16, %309 ], [ %318, %.preheader.i44 ]
  %323 = getelementptr inbounds %struct.List, ptr %322, i64 0, i32 2
  %324 = load ptr, ptr %323, align 8, !tbaa !35
  %325 = load ptr, ptr %322, align 8, !tbaa !26
  store ptr %325, ptr %324, align 8, !tbaa !26
  %326 = load ptr, ptr %322, align 8, !tbaa !26
  %327 = icmp eq ptr %326, null
  br i1 %327, label %removeList.exit46.preheader, label %328

328:                                              ; preds = %.loopexit.i45
  %329 = getelementptr inbounds %struct.List, ptr %326, i64 0, i32 2
  store ptr %324, ptr %329, align 8, !tbaa !35
  br label %removeList.exit46.preheader

removeList.exit46.preheader:                      ; preds = %328, %.loopexit.i45
  br label %removeList.exit46

removeList.exit46:                                ; preds = %removeList.exit46.preheader, %removeList.exit46
  %330 = phi ptr [ %331, %removeList.exit46 ], [ %17, %removeList.exit46.preheader ]
  %331 = load ptr, ptr %330, align 8, !tbaa !26
  %332 = icmp eq ptr %331, null
  br i1 %332, label %addList.exit47, label %removeList.exit46, !llvm.loop !36

addList.exit47:                                   ; preds = %removeList.exit46
  %333 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %334 = getelementptr inbounds %struct.List, ptr %333, i64 0, i32 1
  store ptr %307, ptr %334, align 8, !tbaa !27
  store ptr null, ptr %333, align 8, !tbaa !26
  %335 = getelementptr inbounds %struct.List, ptr %333, i64 0, i32 2
  store ptr %330, ptr %335, align 8, !tbaa !35
  store ptr %333, ptr %330, align 8, !tbaa !26
  br label %340

336:                                              ; preds = %301
  %337 = getelementptr inbounds %struct.Patient, ptr %307, i64 0, i32 1
  %338 = load i32, ptr %337, align 4, !tbaa !30
  %339 = add nsw i32 %338, 1
  store i32 %339, ptr %337, align 4, !tbaa !30
  br label %340

340:                                              ; preds = %336, %addList.exit47
  %341 = icmp eq ptr %304, null
  br i1 %341, label %.loopexit, label %299, !llvm.loop !40

.loopexit:                                        ; preds = %.preheader51, %340, %.loopexit53
  %342 = getelementptr inbounds %struct.Village, ptr %0, i64 0, i32 5
  %343 = load i64, ptr %342, align 8, !tbaa !20
  %344 = xor i64 %343, 123459876
  %345 = sdiv i64 %344, 127773
  %346 = mul nsw i64 %345, -127773
  %347 = add i64 %346, %344
  %348 = mul nsw i64 %347, 16807
  %349 = mul nsw i64 %345, -2836
  %350 = add i64 %348, %349
  %351 = xor i64 %350, 123459876
  %352 = icmp slt i64 %350, 0
  %353 = add nsw i64 %351, 2147483647
  %354 = select i1 %352, i64 %353, i64 %351
  %355 = sitofp i64 %354 to double
  %356 = fmul double %355, 0x3E00000000200000
  %357 = fptrunc double %356 to float
  %358 = fmul float %357, 0x41E0000000000000
  %359 = fptosi float %358 to i64
  store i64 %359, ptr %342, align 8, !tbaa !20
  %360 = fpext float %357 to double
  %361 = fcmp ogt double %360, 6.660000e-01
  br i1 %361, label %362, label %384

362:                                              ; preds = %.loopexit
  %363 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %364 = getelementptr inbounds %struct.Patient, ptr %363, i64 0, i32 1
  store i32 0, ptr %364, align 4, !tbaa !30
  %365 = getelementptr inbounds %struct.Patient, ptr %363, i64 0, i32 2
  store i32 0, ptr %365, align 8, !tbaa !33
  %366 = getelementptr inbounds %struct.Patient, ptr %363, i64 0, i32 3
  store ptr %0, ptr %366, align 8, !tbaa !43
  store i32 1, ptr %363, align 8, !tbaa !28
  %367 = load i32, ptr %15, align 4, !tbaa !42
  %368 = icmp sgt i32 %367, 0
  br i1 %368, label %369, label %.preheader

369:                                              ; preds = %362
  %370 = add nsw i32 %367, -1
  store i32 %370, ptr %15, align 4, !tbaa !42
  br label %371

371:                                              ; preds = %371, %369
  %372 = phi ptr [ %373, %371 ], [ %17, %369 ]
  %373 = load ptr, ptr %372, align 8, !tbaa !26
  %374 = icmp eq ptr %373, null
  br i1 %374, label %addList.exit48, label %371, !llvm.loop !36

addList.exit48:                                   ; preds = %371
  %375 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %376 = getelementptr inbounds %struct.List, ptr %375, i64 0, i32 1
  store ptr %363, ptr %376, align 8, !tbaa !27
  store ptr null, ptr %375, align 8, !tbaa !26
  %377 = getelementptr inbounds %struct.List, ptr %375, i64 0, i32 2
  store ptr %372, ptr %377, align 8, !tbaa !35
  store ptr %375, ptr %372, align 8, !tbaa !26
  store i32 3, ptr %365, align 8, !tbaa !33
  store i32 3, ptr %364, align 4, !tbaa !30
  br label %384

.preheader:                                       ; preds = %362, %.preheader
  %378 = phi ptr [ %379, %.preheader ], [ %16, %362 ]
  %379 = load ptr, ptr %378, align 8, !tbaa !26
  %380 = icmp eq ptr %379, null
  br i1 %380, label %addList.exit49, label %.preheader, !llvm.loop !36

addList.exit49:                                   ; preds = %.preheader
  %381 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
  %382 = getelementptr inbounds %struct.List, ptr %381, i64 0, i32 1
  store ptr %363, ptr %382, align 8, !tbaa !27
  store ptr null, ptr %381, align 8, !tbaa !26
  %383 = getelementptr inbounds %struct.List, ptr %381, i64 0, i32 2
  store ptr %378, ptr %383, align 8, !tbaa !35
  store ptr %381, ptr %378, align 8, !tbaa !26
  br label %384

384:                                              ; preds = %addList.exit49, %addList.exit48, %.loopexit, %1
  %385 = phi ptr [ null, %1 ], [ %284, %addList.exit48 ], [ %284, %addList.exit49 ], [ %284, %.loopexit ]
  ret ptr %385
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
  %9 = tail call noalias dereferenceable_or_null(24) ptr @malloc(i64 noundef 24) #15
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
  br i1 %5, label %.loopexit, label %.preheader

.preheader:                                       ; preds = %2, %.preheader
  %6 = phi ptr [ %7, %.preheader ], [ %0, %2 ]
  %7 = load ptr, ptr %6, align 8, !tbaa !26
  %8 = getelementptr inbounds %struct.List, ptr %7, i64 0, i32 1
  %9 = load ptr, ptr %8, align 8, !tbaa !27
  %10 = icmp eq ptr %9, %1
  br i1 %10, label %.loopexit, label %.preheader, !llvm.loop !34

.loopexit:                                        ; preds = %.preheader, %2
  %11 = phi ptr [ %0, %2 ], [ %7, %.preheader ]
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

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #12

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @llvm.prefetch.p0(ptr nocapture readonly, i32 immarg, i32 immarg, i32 immarg) #13

attributes #0 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree willreturn }
attributes #5 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #6 = { nofree nosync nounwind memory(read, inaccessiblemem: none) uwtable "min-legal-vector-width"="64" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { mustprogress nofree nounwind willreturn memory(write, argmem: readwrite, inaccessiblemem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { nofree nounwind uwtable "min-legal-vector-width"="64" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nofree nounwind }
attributes #10 = { nofree norecurse nosync nounwind memory(readwrite, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #13 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite) }
attributes #14 = { nounwind }
attributes #15 = { nounwind allocsize(0) }

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
