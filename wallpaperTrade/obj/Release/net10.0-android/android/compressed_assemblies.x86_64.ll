; ModuleID = 'compressed_assemblies.x86_64.ll'
source_filename = "compressed_assemblies.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.CompressedAssemblyDescriptor = type {
	i32, ; uint32_t uncompressed_file_size
	i1, ; bool loaded
	i32 ; uint32_t buffer_offset
}

@compressed_assembly_count = dso_local local_unnamed_addr constant i32 14, align 4

@compressed_assembly_descriptors = dso_local local_unnamed_addr global [14 x %struct.CompressedAssemblyDescriptor] [
	%struct.CompressedAssemblyDescriptor {
		i32 2560, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 0; uint32_t buffer_offset
	}, ; 0: _Microsoft.Android.Resource.Designer
	%struct.CompressedAssemblyDescriptor {
		i32 25088, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 2560; uint32_t buffer_offset
	}, ; 1: wallpaperTrade
	%struct.CompressedAssemblyDescriptor {
		i32 10752, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 27648; uint32_t buffer_offset
	}, ; 2: System.Collections
	%struct.CompressedAssemblyDescriptor {
		i32 11776, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 38400; uint32_t buffer_offset
	}, ; 3: System.Console
	%struct.CompressedAssemblyDescriptor {
		i32 16896, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 50176; uint32_t buffer_offset
	}, ; 4: System.Linq
	%struct.CompressedAssemblyDescriptor {
		i32 9216, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 67072; uint32_t buffer_offset
	}, ; 5: System.Runtime.InteropServices
	%struct.CompressedAssemblyDescriptor {
		i32 6144, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 76288; uint32_t buffer_offset
	}, ; 6: System.Runtime
	%struct.CompressedAssemblyDescriptor {
		i32 13312, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 82432; uint32_t buffer_offset
	}, ; 7: System.Security.Cryptography
	%struct.CompressedAssemblyDescriptor {
		i32 5120, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 95744; uint32_t buffer_offset
	}, ; 8: System.Threading.Thread
	%struct.CompressedAssemblyDescriptor {
		i32 12288, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 100864; uint32_t buffer_offset
	}, ; 9: System.Threading
	%struct.CompressedAssemblyDescriptor {
		i32 1393664, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 113152; uint32_t buffer_offset
	}, ; 10: System.Private.CoreLib
	%struct.CompressedAssemblyDescriptor {
		i32 154624, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 1506816; uint32_t buffer_offset
	}, ; 11: Java.Interop
	%struct.CompressedAssemblyDescriptor {
		i32 11776, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 1661440; uint32_t buffer_offset
	}, ; 12: Mono.Android.Runtime
	%struct.CompressedAssemblyDescriptor {
		i32 485888, ; uint32_t uncompressed_file_size
		i1 false, ; bool loaded
		i32 1673216; uint32_t buffer_offset
	} ; 13: Mono.Android
], align 16

@uncompressed_assemblies_data_size = dso_local local_unnamed_addr constant i32 2159104, align 4

@uncompressed_assemblies_data_buffer = dso_local local_unnamed_addr global [2159104 x i8] zeroinitializer, align 16

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/10.0.1xx @ d549e1dc4e2a083b08b4f24cb5495e81b99d79b5"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
