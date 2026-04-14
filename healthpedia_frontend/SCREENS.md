# Healthpedia App — Screen Architecture (screens.md)

## 1. Onboarding Flow

Purpose: User acquisition, profile setup, initial health context capture

* SplashScreen
* OverviewCarousel

  * Overview1
  * Overview2
  * Overview3
* BasicDetailsForm
* HealthConditionSelection
* HealthTrackersSelection
* PermissionsRequest
* OnboardingLoading

---

## 2. Main App (Post Login)

### 2.1 Home / Summary

Purpose: Daily health overview + entry point to all modules

* SummaryHome

---

### 2.2 Reminders Module

Purpose: Medication, food, and health activity tracking

* RemindersMain
* RemindersHistory

#### Bottom Sheets

* AddReminderSheet
* AddReminderRepeatSheet

---

### 2.3 AI Assistant

Purpose: Conversational health intelligence

* AskAIChat

---

### 2.4 Records Module

Purpose: Longitudinal health data storage and retrieval

#### Reports

* ReportsList

* UploadReport

* ReportCategory (Dynamic)

  * ThyroidReports

    * ThyroidReportsSort
    * ThyroidReportDetail

#### Symptoms

* SymptomsList

  * SymptomDetail (Fatigue)

#### Prescriptions

* PrescriptionsList

  * PrescriptionDetail

##### Prescription Bottom Sheets

* PrescriptionReminderSheet
* MedicinesAddMoreSheet
* MedicinesListSheet
* AddReminderSheet (Shared)

#### Notes

* NotesList
* NoteDetail

---

### 2.5 Profile Module

Purpose: User identity, health profile, and settings

#### Profile Overview

* ProfileHome

---

#### Profile Photo

* ChangeProfilePhoto

  * ChangePhotoV1
  * ChangePhotoV2
  * ChangePhotoV3

---

#### Personal Information

* PersonalInfo

  * EditName

  * EditEmail

    * EmailOTPNoData
    * EmailOTPData
    * EmailOTPError
    * EmailOTPSuccess

  * EditPhone

  * EditDOB

  * EditAge

  * EditGender

  * EditHeight

  * EditWeight

  * EditBloodGroup

  * EditCity

---

#### Medical Data

##### Conditions

* ConditionsList
* AddCondition

##### Allergies

* AllergiesList
* AddAllergy
* AllergiesAbout

##### Family History

* FamilyHistoryList
* AddFamilyHistoryRecord
* FamilyHistoryAbout
* FamilyHistoryErrorNoAccess

##### Insurance

* InsuranceList
* AddInsurancePolicy
* InsuranceAbout

---

#### Family & Friends (Multi-Profile System)

* FamilyList

* AddMember

* Requests

  * RequestList
  * RequestAccept

* SharedProfiles

* FamilyAbout

##### Member Profile (Dynamic)

* MemberProfile (MaheshSahu)

  * MemberConditions

  * MemberPrescriptions

  * MemberAllergies

  * MemberReports

    * MemberReportCategory (Thyroid)

      * MemberReportDetail

  * MemberSymptoms

    * MemberSymptomDetail (Fatigue)

  * MemberFamilyHistory

  * MemberInsurance

---

#### ABHA Integration

* ABHAFirstTime
* ABHAConnect

  * ABHAOTP
* ABHAConnecting
* ABHADashboard

---

#### Devices & Integrations

* DevicesAndApps

---

#### Notifications

* NotificationSettings

---

#### App Settings

* AppSettings

---

#### Data & Privacy

* DataPrivacy

---

#### Legal

* LegalInformation

---

## 3. Shared Components (Global)

### Bottom Sheets

* AddReminderSheet
* RepeatSelectorSheet
* MedicineSelectorSheet

### Modals

* OTPModal
* ErrorModal
* SuccessModal

---

## 4. Navigation Structure

### Bottom Navigation

* Home (Summary)
* Records
* Ask AI
* Reminders
* Profile

---

## 5. Key System Notes

* All "ReportCategory" and "MemberProfile" screens are dynamic (API-driven)
* Bottom sheets are reusable across modules
* AI Chat should maintain persistent session context
* Records module must support deep linking (e.g., open specific report)
* Profile module acts as system configuration layer

---
