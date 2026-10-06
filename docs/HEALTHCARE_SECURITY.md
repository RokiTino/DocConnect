# DocConnect patient-data release gates

DocConnect shares the FieldMed backend with Zoctor. The full cross-app checklist is in Zoctor's `docs/HEALTHCARE_SECURITY.md`. North Macedonia is the first patient jurisdiction; HIPAA readiness is an additional target if US-regulated ePHI is handled. Neither app should be described as HIPAA compliant yet.

Patient accounts may view only their own appointments and notifications under FieldMed row-level security. A doctor is not linked to a patient until the patient accepts a pending care-team request in DocConnect. The approval screen explains that the doctor can then see appointments and checkup summaries and arrange specialist care.

Before real patient use, verify account recovery, invitation expiry and redirect allow-list, secure session storage and sign-out on lost devices, cross-account API isolation, accessibility, PHI-free crash logs and notifications, backup restoration, audit of clinical record reads, retention/deletion, incident response and the applicable vendor agreements. Clinician MFA and FieldMed leaked-password protection are also release gates. For US-regulated ePHI, Supabase requires a signed BAA and HIPAA add-on/High Compliance configuration; see [Supabase HIPAA Projects](https://supabase.com/docs/guides/platform/hipaa-projects).
