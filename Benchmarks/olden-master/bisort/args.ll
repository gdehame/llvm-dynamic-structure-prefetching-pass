; ModuleID = 'args.c'
source_filename = "args.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@flag = external local_unnamed_addr global i32, align 4
@NumNodes = external local_unnamed_addr global i32, align 4
@NDim = external local_unnamed_addr global i32, align 4

; Function Attrs: nofree norecurse nosync nounwind memory(none) uwtable
define dso_local i32 @mylog(i32 noundef %0) local_unnamed_addr #0 !dbg !15 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !19, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.value(metadata i32 0, metadata !20, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.value(metadata i32 1, metadata !21, metadata !DIExpression()), !dbg !22
  %2 = icmp sgt i32 %0, 1, !dbg !23
  br i1 %2, label %3, label %9, !dbg !24

3:                                                ; preds = %1, %3
  %4 = phi i32 [ %6, %3 ], [ 1, %1 ]
  %5 = phi i32 [ %7, %3 ], [ 0, %1 ]
  call void @llvm.dbg.value(metadata i32 %4, metadata !21, metadata !DIExpression()), !dbg !22
  call void @llvm.dbg.value(metadata i32 %5, metadata !20, metadata !DIExpression()), !dbg !22
  %6 = shl nsw i32 %4, 1, !dbg !25
  call void @llvm.dbg.value(metadata i32 %6, metadata !21, metadata !DIExpression()), !dbg !22
  %7 = add nuw nsw i32 %5, 1, !dbg !27
  call void @llvm.dbg.value(metadata i32 %7, metadata !20, metadata !DIExpression()), !dbg !22
  %8 = icmp slt i32 %6, %0, !dbg !23
  br i1 %8, label %3, label %9, !dbg !24, !llvm.loop !28

9:                                                ; preds = %3, %1
  %10 = phi i32 [ 0, %1 ], [ %7, %3 ], !dbg !22
  ret i32 %10, !dbg !31
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @dealwithargs(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #1 !dbg !32 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !36, metadata !DIExpression()), !dbg !39
  call void @llvm.dbg.value(metadata ptr %1, metadata !37, metadata !DIExpression()), !dbg !39
  %3 = icmp sgt i32 %0, 3, !dbg !40
  br i1 %3, label %4, label %9, !dbg !42

4:                                                ; preds = %2
  %5 = getelementptr inbounds ptr, ptr %1, i64 3, !dbg !43
  %6 = load ptr, ptr %5, align 8, !dbg !43, !tbaa !44
  call void @llvm.dbg.value(metadata ptr %6, metadata !48, metadata !DIExpression()), !dbg !56
  %7 = tail call i64 @strtol(ptr nocapture noundef nonnull %6, ptr noundef null, i32 noundef 10) #4, !dbg !58
  %8 = trunc i64 %7 to i32, !dbg !59
  store i32 %8, ptr @flag, align 4, !dbg !60, !tbaa !61
  br label %11, !dbg !63

9:                                                ; preds = %2
  store i32 1, ptr @flag, align 4, !dbg !60, !tbaa !61
  %10 = icmp eq i32 %0, 3, !dbg !64
  br i1 %10, label %11, label %16, !dbg !63

11:                                               ; preds = %9, %4
  %12 = getelementptr inbounds ptr, ptr %1, i64 2, !dbg !66
  %13 = load ptr, ptr %12, align 8, !dbg !66, !tbaa !44
  call void @llvm.dbg.value(metadata ptr %13, metadata !48, metadata !DIExpression()), !dbg !67
  %14 = tail call i64 @strtol(ptr nocapture noundef nonnull %13, ptr noundef null, i32 noundef 10) #4, !dbg !69
  %15 = trunc i64 %14 to i32, !dbg !70
  store i32 %15, ptr @NumNodes, align 4, !dbg !71, !tbaa !61
  br label %18, !dbg !72

16:                                               ; preds = %9
  store i32 4, ptr @NumNodes, align 4, !dbg !71, !tbaa !61
  %17 = icmp sgt i32 %0, 1, !dbg !73
  br i1 %17, label %18, label %25, !dbg !72

18:                                               ; preds = %16, %11
  %19 = getelementptr inbounds ptr, ptr %1, i64 1, !dbg !75
  %20 = load ptr, ptr %19, align 8, !dbg !75, !tbaa !44
  call void @llvm.dbg.value(metadata ptr %20, metadata !48, metadata !DIExpression()), !dbg !76
  %21 = tail call i64 @strtol(ptr nocapture noundef nonnull %20, ptr noundef null, i32 noundef 10) #4, !dbg !78
  %22 = trunc i64 %21 to i32, !dbg !79
  call void @llvm.dbg.value(metadata i32 %22, metadata !38, metadata !DIExpression()), !dbg !39
  %23 = load i32, ptr @NumNodes, align 4, !dbg !80, !tbaa !61
  call void @llvm.dbg.value(metadata i32 %23, metadata !19, metadata !DIExpression()), !dbg !81
  call void @llvm.dbg.value(metadata i32 0, metadata !20, metadata !DIExpression()), !dbg !81
  call void @llvm.dbg.value(metadata i32 1, metadata !21, metadata !DIExpression()), !dbg !81
  %24 = icmp sgt i32 %23, 1, !dbg !83
  br i1 %24, label %25, label %34, !dbg !84

25:                                               ; preds = %16, %18
  %26 = phi i32 [ %22, %18 ], [ 32768, %16 ]
  %27 = phi i32 [ %23, %18 ], [ 4, %16 ]
  br label %28, !dbg !84

28:                                               ; preds = %25, %28
  %29 = phi i32 [ %31, %28 ], [ 1, %25 ]
  %30 = phi i32 [ %32, %28 ], [ 0, %25 ]
  call void @llvm.dbg.value(metadata i32 %29, metadata !21, metadata !DIExpression()), !dbg !81
  call void @llvm.dbg.value(metadata i32 %30, metadata !20, metadata !DIExpression()), !dbg !81
  %31 = shl nsw i32 %29, 1, !dbg !85
  call void @llvm.dbg.value(metadata i32 %31, metadata !21, metadata !DIExpression()), !dbg !81
  %32 = add nuw nsw i32 %30, 1, !dbg !86
  call void @llvm.dbg.value(metadata i32 %32, metadata !20, metadata !DIExpression()), !dbg !81
  %33 = icmp slt i32 %31, %27, !dbg !83
  br i1 %33, label %28, label %34, !dbg !84, !llvm.loop !87

34:                                               ; preds = %28, %18
  %35 = phi i32 [ %22, %18 ], [ %26, %28 ]
  %36 = phi i32 [ 0, %18 ], [ %32, %28 ], !dbg !81
  store i32 %36, ptr @NDim, align 4, !dbg !89, !tbaa !61
  ret i32 %35, !dbg !90
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !91 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

attributes #0 = { nofree norecurse nosync nounwind memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!8, !9, !10, !11, !12, !13}
!llvm.ident = !{!14}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 16.0.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "args.c", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/bisort", checksumkind: CSK_MD5, checksum: "a8cde968cf40fa4616e8365f79e6e96f")
!2 = !{!3, !4, !7}
!3 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!6 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!8 = !{i32 7, !"Dwarf Version", i32 5}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{i32 8, !"PIC Level", i32 2}
!12 = !{i32 7, !"PIE Level", i32 2}
!13 = !{i32 7, !"uwtable", i32 2}
!14 = !{!"clang version 16.0.0"}
!15 = distinct !DISubprogram(name: "mylog", scope: !1, file: !1, line: 7, type: !16, scopeLine: 7, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !18)
!16 = !DISubroutineType(types: !17)
!17 = !{!3, !3}
!18 = !{!19, !20, !21}
!19 = !DILocalVariable(name: "num", arg: 1, scope: !15, file: !1, line: 7, type: !3)
!20 = !DILocalVariable(name: "j", scope: !15, file: !1, line: 8, type: !3)
!21 = !DILocalVariable(name: "k", scope: !15, file: !1, line: 8, type: !3)
!22 = !DILocation(line: 0, scope: !15)
!23 = !DILocation(line: 10, column: 10, scope: !15)
!24 = !DILocation(line: 10, column: 3, scope: !15)
!25 = !DILocation(line: 10, column: 19, scope: !26)
!26 = distinct !DILexicalBlock(scope: !15, file: !1, line: 10, column: 16)
!27 = !DILocation(line: 10, column: 25, scope: !26)
!28 = distinct !{!28, !24, !29, !30}
!29 = !DILocation(line: 10, column: 29, scope: !15)
!30 = !{!"llvm.loop.mustprogress"}
!31 = !DILocation(line: 11, column: 3, scope: !15)
!32 = distinct !DISubprogram(name: "dealwithargs", scope: !1, file: !1, line: 14, type: !33, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !35)
!33 = !DISubroutineType(types: !34)
!34 = !{!3, !3, !4}
!35 = !{!36, !37, !38}
!36 = !DILocalVariable(name: "argc", arg: 1, scope: !32, file: !1, line: 14, type: !3)
!37 = !DILocalVariable(name: "argv", arg: 2, scope: !32, file: !1, line: 14, type: !4)
!38 = !DILocalVariable(name: "size", scope: !32, file: !1, line: 16, type: !3)
!39 = !DILocation(line: 0, scope: !32)
!40 = !DILocation(line: 18, column: 12, scope: !41)
!41 = distinct !DILexicalBlock(scope: !32, file: !1, line: 18, column: 7)
!42 = !DILocation(line: 18, column: 7, scope: !32)
!43 = !DILocation(line: 19, column: 17, scope: !41)
!44 = !{!45, !45, i64 0}
!45 = !{!"any pointer", !46, i64 0}
!46 = !{!"omnipotent char", !47, i64 0}
!47 = !{!"Simple C/C++ TBAA"}
!48 = !DILocalVariable(name: "__nptr", arg: 1, scope: !49, file: !50, line: 362, type: !53)
!49 = distinct !DISubprogram(name: "atoi", scope: !50, file: !50, line: 362, type: !51, scopeLine: 363, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !55)
!50 = !DIFile(filename: "/usr/include/stdlib.h", directory: "", checksumkind: CSK_MD5, checksum: "02258fad21adf111bb9df9825e61954a")
!51 = !DISubroutineType(types: !52)
!52 = !{!3, !53}
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!54 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !6)
!55 = !{!48}
!56 = !DILocation(line: 0, scope: !49, inlinedAt: !57)
!57 = distinct !DILocation(line: 19, column: 12, scope: !41)
!58 = !DILocation(line: 364, column: 16, scope: !49, inlinedAt: !57)
!59 = !DILocation(line: 364, column: 10, scope: !49, inlinedAt: !57)
!60 = !DILocation(line: 0, scope: !41)
!61 = !{!62, !62, i64 0}
!62 = !{!"int", !46, i64 0}
!63 = !DILocation(line: 23, column: 7, scope: !32)
!64 = !DILocation(line: 23, column: 12, scope: !65)
!65 = distinct !DILexicalBlock(scope: !32, file: !1, line: 23, column: 7)
!66 = !DILocation(line: 24, column: 21, scope: !65)
!67 = !DILocation(line: 0, scope: !49, inlinedAt: !68)
!68 = distinct !DILocation(line: 24, column: 16, scope: !65)
!69 = !DILocation(line: 364, column: 16, scope: !49, inlinedAt: !68)
!70 = !DILocation(line: 364, column: 10, scope: !49, inlinedAt: !68)
!71 = !DILocation(line: 0, scope: !65)
!72 = !DILocation(line: 28, column: 7, scope: !32)
!73 = !DILocation(line: 28, column: 12, scope: !74)
!74 = distinct !DILexicalBlock(scope: !32, file: !1, line: 28, column: 7)
!75 = !DILocation(line: 29, column: 17, scope: !74)
!76 = !DILocation(line: 0, scope: !49, inlinedAt: !77)
!77 = distinct !DILocation(line: 29, column: 12, scope: !74)
!78 = !DILocation(line: 364, column: 16, scope: !49, inlinedAt: !77)
!79 = !DILocation(line: 364, column: 10, scope: !49, inlinedAt: !77)
!80 = !DILocation(line: 33, column: 16, scope: !32)
!81 = !DILocation(line: 0, scope: !15, inlinedAt: !82)
!82 = distinct !DILocation(line: 33, column: 10, scope: !32)
!83 = !DILocation(line: 10, column: 10, scope: !15, inlinedAt: !82)
!84 = !DILocation(line: 10, column: 3, scope: !15, inlinedAt: !82)
!85 = !DILocation(line: 10, column: 19, scope: !26, inlinedAt: !82)
!86 = !DILocation(line: 10, column: 25, scope: !26, inlinedAt: !82)
!87 = distinct !{!87, !84, !88, !30}
!88 = !DILocation(line: 10, column: 29, scope: !15, inlinedAt: !82)
!89 = !DILocation(line: 33, column: 8, scope: !32)
!90 = !DILocation(line: 34, column: 3, scope: !32)
!91 = !DISubprogram(name: "strtol", scope: !50, file: !50, line: 177, type: !92, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !97)
!92 = !DISubroutineType(types: !93)
!93 = !{!94, !95, !96, !3}
!94 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!95 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !53)
!96 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !4)
!97 = !{}
