; ModuleID = 'args.c'
source_filename = "args.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@NumNodes = dso_local local_unnamed_addr global i32 1, align 4, !dbg !0

; Function Attrs: mustprogress nofree nounwind willreturn memory(read) uwtable
define dso_local i32 @dealwithargs(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 !dbg !13 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !20, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.value(metadata ptr %1, metadata !21, metadata !DIExpression()), !dbg !23
  %3 = icmp sgt i32 %0, 1, !dbg !24
  br i1 %3, label %4, label %8, !dbg !26

4:                                                ; preds = %2
  %5 = getelementptr inbounds ptr, ptr %1, i64 1, !dbg !27
  %6 = load ptr, ptr %5, align 8, !dbg !27, !tbaa !28
  %7 = tail call i32 @atoi(ptr nocapture noundef %6), !dbg !32
  call void @llvm.dbg.value(metadata i32 %7, metadata !22, metadata !DIExpression()), !dbg !23
  br label %8, !dbg !33

8:                                                ; preds = %2, %4
  %9 = phi i32 [ %7, %4 ], [ 64, %2 ], !dbg !34
  call void @llvm.dbg.value(metadata i32 %9, metadata !22, metadata !DIExpression()), !dbg !23
  ret i32 %9, !dbg !35
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(read)
declare !dbg !36 i32 @atoi(ptr nocapture noundef) local_unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { mustprogress nofree nounwind willreturn memory(read) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nounwind willreturn memory(read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!6, !7, !8, !9, !10, !11}
!llvm.ident = !{!12}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "NumNodes", scope: !2, file: !3, line: 5, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "clang version 16.0.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "args.c", directory: "/home/jab/M1/Internship/Benchmarks/olden-master/mst", checksumkind: CSK_MD5, checksum: "e1d04a89e3bc77af81eaefc1e1ceadf1")
!4 = !{!0}
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{i32 7, !"Dwarf Version", i32 5}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{i32 8, !"PIC Level", i32 2}
!10 = !{i32 7, !"PIE Level", i32 2}
!11 = !{i32 7, !"uwtable", i32 2}
!12 = !{!"clang version 16.0.0"}
!13 = distinct !DISubprogram(name: "dealwithargs", scope: !3, file: !3, line: 7, type: !14, scopeLine: 7, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !19)
!14 = !DISubroutineType(types: !15)
!15 = !{!5, !5, !16}
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !{!20, !21, !22}
!20 = !DILocalVariable(name: "argc", arg: 1, scope: !13, file: !3, line: 7, type: !5)
!21 = !DILocalVariable(name: "argv", arg: 2, scope: !13, file: !3, line: 7, type: !16)
!22 = !DILocalVariable(name: "level", scope: !13, file: !3, line: 8, type: !5)
!23 = !DILocation(line: 0, scope: !13)
!24 = !DILocation(line: 10, column: 12, scope: !25)
!25 = distinct !DILexicalBlock(scope: !13, file: !3, line: 10, column: 7)
!26 = !DILocation(line: 10, column: 7, scope: !13)
!27 = !DILocation(line: 11, column: 18, scope: !25)
!28 = !{!29, !29, i64 0}
!29 = !{!"any pointer", !30, i64 0}
!30 = !{!"omnipotent char", !31, i64 0}
!31 = !{!"Simple C/C++ TBAA"}
!32 = !DILocation(line: 11, column: 13, scope: !25)
!33 = !DILocation(line: 11, column: 5, scope: !25)
!34 = !DILocation(line: 0, scope: !25)
!35 = !DILocation(line: 15, column: 3, scope: !13)
!36 = !DISubprogram(name: "atoi", scope: !3, file: !3, line: 3, type: !37, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !41)
!37 = !DISubroutineType(types: !38)
!38 = !{!5, !39}
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!40 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !18)
!41 = !{}
