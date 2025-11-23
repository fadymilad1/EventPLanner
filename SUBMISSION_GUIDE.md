# Phase 0 & Phase 1 Submission Guide

## 📦 What to Submit

### Phase 0 (Already Complete - No Separate Submission)
Phase 0 is included in Phase 1 submission.

### Phase 1 Submission

Submit **ONE ZIP FILE** named: `ID1_ID2_ID3_TA_NAME.zip`

The zip file must contain:

1. **Text File:** `ID1_ID2_ID3_TA_NAME.txt`
2. **Postman Collection:** `EventPlanner_API.postman_collection.json`

---

## 📝 Step-by-Step Submission Process

### Step 1: Create Team Info Text File

1. Open `TEAM_INFO_TEMPLATE.txt`
2. Fill in the following:
   - Replace `[Name 1]` with first team member's name
   - Replace `[ID1]` with first team member's ID
   - Repeat for all team members
   - Replace `[Your TA's Name]` with your TA's name
   - Replace GitHub URLs with your actual repository URLs

3. Save the file as: `ID1_ID2_ID3_TA_NAME.txt`
   - Example: `123456_789012_345678_TA_NAME.txt`
   - Use actual IDs, not placeholders

### Step 2: Verify Postman Collection

1. Location: `event-backend/EventPlanner_API.postman_collection.json`
2. Verify it includes all endpoints:
   - ✅ Auth (Register, Login)
   - ✅ Events (Create, Get Organized, Get Invited, Get by ID, Update, Delete, Search)
   - ✅ Invitations (Invite, Get Event Invitations, Get User Invitations, Update Status, Delete)
   - ✅ Attendance (Set Status, Get Event Attendance, Get My Attendance, Get Attending Events)
   - ✅ Users (Search)

### Step 3: Set Up GitHub Repositories

1. **Create Backend Repository:**
   ```bash
   cd event-backend
   git init
   git add .
   git commit -m "Phase 1: Complete backend implementation"
   # Push to GitHub
   ```

2. **Create Frontend Repository:**
   ```bash
   cd event-frontend
   git init
   git add .
   git commit -m "Phase 1: Complete frontend implementation"
   # Push to GitHub
   ```

3. **Add TA as Collaborator:**
   - Go to repository settings on GitHub
   - Navigate to "Collaborators"
   - Add your TA's GitHub username
   - Give them "Read" or "Write" access

### Step 4: Create Zip File

1. Create a folder named: `ID1_ID2_ID3_TA_NAME`
2. Copy these files into the folder:
   - `ID1_ID2_ID3_TA_NAME.txt` (your team info file)
   - `EventPlanner_API.postman_collection.json` (from event-backend folder)
3. Zip the folder
4. Name the zip: `ID1_ID2_ID3_TA_NAME.zip`

### Step 5: Submit

1. Upload the zip file to Google Classroom
2. Make sure it's submitted before the deadline
3. Verify all commits are made before deadline (any commits after deadline are late)

---

## ✅ Pre-Submission Checklist

### Code Verification:
- [ ] All Phase 0 features work (Register, Login)
- [ ] All Phase 1 features work (Events, Invitations, Attendance, Search)
- [ ] No 500 errors in server console
- [ ] No errors in browser console
- [ ] Database properly set up
- [ ] All tables created (users, events, event_invitations, event_attendance)

### Deliverables:
- [ ] Text file created with correct format
- [ ] Text file renamed correctly (ID1_ID2_ID3_TA_NAME.txt)
- [ ] Postman collection verified
- [ ] Postman collection included in zip

### GitHub:
- [ ] Backend repository created
- [ ] Frontend repository created
- [ ] All code committed
- [ ] TA added as collaborator
- [ ] Repository links in text file are correct

### Testing:
- [ ] Tested registration
- [ ] Tested login
- [ ] Tested event creation
- [ ] Tested viewing events
- [ ] Tested invitations
- [ ] Tested attendance
- [ ] Tested search

### Final Check:
- [ ] Zip file created correctly
- [ ] Zip file contains both required files
- [ ] Zip file named correctly
- [ ] Ready to submit

---

## 📋 Example Text File Content

```
Team Members:
- John Doe (123456)
- Jane Smith (789012)
- Bob Johnson (345678)

TA Name: Dr. Smith

GitHub Repositories:
- Backend: https://github.com/yourusername/event-backend
- Frontend: https://github.com/yourusername/event-frontend

Note: Please ensure your TA is added as a collaborator to both repositories.
```

---

## ⚠️ Important Notes

1. **Deadline:** November 14th (check your specific deadline)
2. **Late Submissions:** Not allowed
3. **GitHub Commits:** Any commits after deadline are considered late
4. **TA Access:** Must add TA as collaborator before submission
5. **File Naming:** Must follow exact format: `ID1_ID2_ID3_TA_NAME`

---

## 🚨 Common Mistakes to Avoid

1. ❌ Forgetting to rename the text file
2. ❌ Using placeholders instead of actual IDs
3. ❌ Not adding TA as collaborator
4. ❌ Wrong zip file name format
5. ❌ Missing Postman collection in zip
6. ❌ Committing code after deadline
7. ❌ Wrong GitHub repository URLs

---

## 📞 Need Help?

If you have questions:
1. Check `PHASE1_DELIVERABLES_GUIDE.md`
2. Review `FINAL_VERIFICATION_CHECKLIST.md`
3. Check `TROUBLESHOOTING.md` for common issues

---

## 🎉 Good Luck!

You've completed Phase 0 and Phase 1! Make sure everything is tested and ready before submission.

**Remember:**
- Test everything thoroughly
- Double-check file names
- Verify GitHub links
- Submit before deadline

Good luck with your submission! 🚀

