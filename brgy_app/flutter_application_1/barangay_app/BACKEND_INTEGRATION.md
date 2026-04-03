# Backend Integration Guide

## Overview
The Flutter app is now fully integrated with the Barangay 133 backend API. All major features connect to the backend for authentication, data fetching, and submission.

## Configuration

### Update Backend URL
In `lib/services/api_service.dart`, update the `baseUrl` to match your backend server:

```dart
// For local development
static const String baseUrl = 'http://localhost:8000';

// For network testing (replace with your PC's IP)
static const String baseUrl = 'http://192.168.1.100:8000';

// For production
static const String baseUrl = 'https://your-domain.com';
```

## Features Integrated

### 1. Authentication (Login)
- **Endpoint**: `POST /api/login/`
- **Status**: ✅ Fully integrated
- **Features**:
  - Username and password validation
  - JWT token management
  - Role-based access control (Super Admin, Barangay Official, Resident)
  - User role display on dashboard

### 2. Announcements
- **Endpoints**: 
  - `GET /api/announcements/` - Fetch all announcements
  - `POST /api/announcements/` - Create announcement (Official+ only)
- **Status**: ✅ Fully integrated
- **Features**:
  - Real-time announcement fetching from backend
  - Search and filter functionality
  - Pull-to-refresh support
  - No more hardcoded test data

### 3. Feedback & Complaints
- **Endpoints**:
  - `POST /api/feedback/` - Submit feedback
  - `GET /api/feedback/` - View all feedback (Official+ only)
- **Status**: ✅ Fully integrated
- **Features**:
  - Submits to backend instead of local storage
  - File attachment support ready (picker implemented)
  - Confirmation dialog before submission
  - Success/error feedback

### 4. Activity History
- **Endpoint**: `GET /api/activity-history/`
- **Status**: ✅ Fully integrated
- **Features**:
  - Fetches user's personal activity log from backend
  - Pull-to-refresh support
  - Shows login times, submissions, and actions

### 5. Service Layer
- **File**: `lib/services/api_service.dart`
- **Status**: ✅ Implemented
- **Features**:
  - Centralized API management
  - Automatic JWT token handling
  - Error handling and timeouts
  - Role-based permissions checking available

## Testing

### Prerequisites
1. Backend server running on configured URL
2. MongoDB/MySQL database connected to backend
3. Sample user account for testing (e.g., username: `admin`, password: `password123`)

### Test Scenarios

#### 1. Login Flow
```
Username: admin
Password: password123
Expected: Successful login, JWT token received, redirected to dashboard
```

#### 2. Announcements
```
Expected: See announcements from database
Can search and filter announcements
Pull-to-refresh loads latest
```

#### 3. Feedback Submission
```
1. Fill subject and message
2. Optionally attach file (optional)
3. Submit
Expected: Data sent to backend, success message shown
```

#### 4. Activity History
```
Expected: See personal activity history from backend
Shows login times, submissions, notifications received
```

## JWT Token Management

The `ApiService` class automatically:
- Stores JWT token after successful login
- Includes token in all subsequent API requests via `Authorization: Bearer <token>` header
- Clears token on logout
- Provides token getters for UI display if needed

### Session Methods
```dart
// Store token after login
ApiService.setToken(token);
ApiService.setUserRole(role);
ApiService.setUserId(userId);

// Clear on logout
ApiService.clearSession();

// Access token in UI
String? token = ApiService.authToken;
String? role = ApiService.userRole;
```

## Error Handling

The app handles:
- ✅ Network connection errors
- ✅ Invalid credentials (401)
- ✅ Permission denied errors (403)
- ✅ Server errors (500)
- ✅ Timeout errors
- ✅ Missing authentication tokens

All errors display user-friendly SnackBar messages.

## Next Steps (Not Yet Implemented)

### Ready to Implement:
1. **File Upload with Feedback**: Update `submitFeedback()` to support file multipart uploads
2. **Edit/Delete Announcements**: Add UI for officials to manage announcements
3. **Logout Functionality**: Clear session and return to login
4. **Garbage Alerts**: Integrate with `GET /api/notifications/` endpoint
5. **Reports Page**: Integrate with `GET /api/reports/` endpoint
6. **Admin Dashboard**: Create admin-only pages for user/resident management

### Advanced Features:
- Offline mode with local sync
- Push notifications for alerts
- Real-time updates with WebSockets
- Avatar/profile pictures
- Two-factor authentication

## Troubleshooting

### Connection Errors
- Check backend is running: `http://your-url:8000/`
- Verify correct IP/domain in `api_service.dart`
- Check firewall/network connectivity

### Login Fails
- Verify credentials in backend database
- Check user roles are set correctly
- Look at backend logs for auth errors

### Announcements Not Loading
- Check user has proper authentication token
- Verify announcements exist in database
- Check backend logs for query errors

### File Picker Not Working
- Android: Check `AndroidManifest.xml` permissions
- iOS: Check Info.plist permissions
- Web: Check browser file access permissions

## API Documentation Reference

For complete API documentation, see:
- Backend README files in `barangay133/backend/`
- `main.py` - Route definitions
- `schemas.py` - Data validation
- `models.py` - Database models

## Success Indicators ✅

Your integration is complete when:
- [x] Login works with backend credentials
- [x] Announcements load from database
- [x] Feedback submits and appears in backend
- [x] Activity history shows personal actions
- [x] No hardcoded test data visible
- [x] All data persists after app restart
