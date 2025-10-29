enum CourseStateEnum {
  active,
  completed,
  suspended;

  // Convert API status to enum
  static CourseStateEnum fromApiStatus(String status, bool isCompleted) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
        return isCompleted ? CourseStateEnum.completed : CourseStateEnum.active;
      case 'SUSPENDED':
        return CourseStateEnum.suspended;
      default:
        return CourseStateEnum.active;
    }
  }

  // Convert enum to API status string
  String toApiStatus() {
    switch (this) {
      case CourseStateEnum.active:
      case CourseStateEnum.completed:
        return 'ACTIVE';
      case CourseStateEnum.suspended:
        return 'SUSPENDED';
    }
  }
}
