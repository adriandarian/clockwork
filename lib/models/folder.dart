/// Folder model - organizes presets into user-defined groups
library;

import 'package:flutter/material.dart' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';
part 'folder.g.dart';

/// JSON converter for Color
class FolderColorConverter implements JsonConverter<Color, int> {
  const FolderColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.toARGB32();
}

@freezed
class Folder with _$Folder {
  const factory Folder({
    /// Unique identifier
    required String id,
    
    /// Display name
    required String name,
    
    /// Emoji icon for the folder
    @Default('📁') String iconEmoji,
    
    /// Folder accent color
    @FolderColorConverter() @Default(Color(0xFF6366F1)) Color color,
    
    /// Sort order in the folder list
    @Default(0) int sortOrder,
    
    /// Whether the folder is expanded in the UI
    @Default(true) bool isExpanded,
    
    /// Creation timestamp (milliseconds since epoch)
    int? createdAt,
  }) = _Folder;
  
  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
}
