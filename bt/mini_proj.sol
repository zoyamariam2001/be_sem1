// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MedicalRecord {
 // Structure to represent a medical record
 struct Record {
 string diagnosis;
 string treatment;
 uint timestamp;
 }
 // Mapping from patient addresses to their medical records
 mapping(address => Record[]) private patientRecords;
 // Mapping to store authorized healthcare providers
 mapping(address => bool) private authorizedProviders;
 // Event emitted when a new medical record is added
 event RecordAdded(address indexed patient, string diagnosis, string treatment, uint timestamp);
 // Event emitted when a medical record is updated
 event RecordUpdated(address indexed patient, uint index, string diagnosis, string treatment, uint timestamp);
 // Modifier to restrict access to authorized healthcare providers
 modifier onlyAuthorizedProvider() {
 require(authorizedProviders[msg.sender], "Unauthorized provider");
 _;
 }
 // Function to add a medical record for a patient
 function addMedicalRecord(string memory diagnosis, string memory treatment) public {
 require(bytes(diagnosis).length > 0, "Diagnosis cannot be empty");
 patientRecords[msg.sender].push(Record({
 diagnosis: diagnosis,
 treatment: treatment,
 timestamp: block.timestamp 
 }));
 emit RecordAdded(msg.sender, diagnosis, treatment, block.timestamp);
 }
 // Function to maintain a specific medical record for a patient
 function updateMedicalRecord(uint index, string memory diagnosis, string memory treatment) public onlyAuthorizedProvider {
 require(index < patientRecords[msg.sender].length, "Index out of bounds");
 Record storage record = patientRecords[msg.sender][index];
 record.diagnosis = diagnosis;
 record.treatment = treatment;
 record.timestamp = block.timestamp;
 emit RecordUpdated(msg.sender, index, diagnosis, treatment, block.timestamp);
 }
 // Function to get the number of records for a patient
 function getRecordCount() public view returns (uint) {
 return patientRecords[msg.sender].length;
 }
 // Function to get a specific medical record for a patient by index
 function getMedicalRecord(uint index) public view returns (string memory diagnosis, string memory treatment, uint timestamp) {
 require(index < patientRecords[msg.sender].length, "Index out of bounds");
 Record storage record = patientRecords[msg.sender][index];
 return (record.diagnosis, record.treatment, record.timestamp);
 }
 // Function to authorize a healthcare provider to maintain records
 function authorizeProvider(address provider) public {
 require(msg.sender == provider, "Only the patient can authorize a provider");
 authorizedProviders[provider] = true;
 }
 // Function to revoke authorization from a healthcare provider
 function revokeAuthorization(address provider) public {
 require(msg.sender == provider, "Only the patient can revoke authorization");
 authorizedProviders[provider] = false;
 }
}
