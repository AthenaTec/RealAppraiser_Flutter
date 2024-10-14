import 'package:equatable/equatable.dart';

class UpdateCaseStatusByIdEntity extends Equatable {
  final int status;
  final DataEntity data;
  final String msg;

  const UpdateCaseStatusByIdEntity({
    required this.status,
    required this.data,
    required this.msg,
  });

  @override
  List<Object?> get props => [status, data, msg];
}

class DataEntity extends Equatable {
  final dynamic caseId;
  final dynamic agencyBranchId;
  final dynamic bankBranchId;
  final dynamic propertyId;
  final dynamic customerId;
  final dynamic feesId;
  final dynamic workflowId;
  final dynamic reportId;
  final dynamic reportTemplateId;
  final dynamic agencyBranch;
  final dynamic applicantName;
  final dynamic applicantContactNo;
  final dynamic contactPersonName;
  final dynamic contactPersonNumber;
  final dynamic bankContactPersonName;
  final dynamic bankContactPersonNumber;
  final dynamic bankContactPersonEmail;
  final dynamic loanType;
  final dynamic bankReferenceNo;
  final dynamic applicantEmailId;
  final dynamic applicantAddress;
  final dynamic reportType;
  final dynamic reportFile;
  final dynamic bankName;
  final dynamic branchName;
  final dynamic propertyAddress;
  final dynamic pincode;
  final dynamic propertyType;
  final dynamic professionalFees;
  final dynamic propertyCity;
  final dynamic propertyLocality;
  final dynamic villageName;
  final dynamic district;
  final dynamic taluka;
  final dynamic purpose;
  final dynamic taxType;
  final dynamic status;
  final dynamic assignedTo;
  final dynamic assignedBy;
  final dynamic assignedAt;
  final dynamic amountReceived;
  final dynamic fieldStaff;
  final dynamic reportMaker;
  final dynamic reportMakerDate;
  final dynamic reportChecker;
  final dynamic reportFinalizer;
  final dynamic reportDispatcher;
  final dynamic telecaller;
  final dynamic caseSourced;
  final dynamic sourcedBy;
  final dynamic gharvalueCity;
  final dynamic gharvalueLocality;
  final dynamic gharvaluePropertyName;
  final dynamic customerFeedbackReceived;
  final dynamic bankFeedbackReceived;
  final dynamic caseReferenceNumber;
  final dynamic footerReferenceNumber;
  final dynamic appointmentDateTime;
  final dynamic submittedTo;
  final dynamic  createdOn;
  final dynamic createdBy;
  final dynamic modifiedOn;
  final dynamic modifiedBy;
  final dynamic signature1;
  final dynamic signature2;
  final dynamic acceptanceTime;
  final dynamic inspectionTime;
  final dynamic isFromTab;
  final dynamic shareFolder;
  final dynamic reportGenerationTime;
  final dynamic caEmpId;
  final dynamic typeofOwnership;
  final dynamic approvedPlanNumber;
  final dynamic approvedPlanDate;
  final dynamic approvedPlanApprovingAuthority;
  final dynamic approvedPlanPreparedBy;
  final dynamic commencementCertificateNumber;
  final dynamic commencementCertificateDate;
  final dynamic commencementApprovingAuthority;
  final dynamic commencementCertificatePreparedBy;
  final dynamic approvedRoleId;
  final dynamic subBranch;
  final dynamic assignedBranchId;
  final dynamic approvalNote;
  final dynamic rejectionNote;
  final dynamic qcStatus;
  final dynamic qcNote;
  final dynamic qcAssignedOn;
  final dynamic caAgencyBranchId;
  final dynamic fsAgencyBranchId;
  final dynamic rmAgencyBranchId;
  final dynamic rmStatus;
  final dynamic rmNote;
  final dynamic rmAssignedOn;
  final dynamic rmAssignedBy;
  final dynamic rmqcNote;
  final dynamic rmqcStatus;
  final dynamic rmqcAssignedOn;
  final dynamic approvalId;
  final dynamic assignedRaBranchId;
  final dynamic architectEngineerLicenseNo;
  final dynamic caseAdmin;
  final dynamic multiCase;
  final dynamic isCloned;
  final dynamic isTransferedCase;
  final dynamic isSignedDocument;
  final dynamic isSignedDocumentViewed;
  final dynamic qcCompleteNote;
  final dynamic qcCompletedDate;
  final dynamic distanceKm;
  final dynamic straightLineDistanceKm;
  final dynamic uniqueIDofthevaluation;
  final dynamic productSchemeName;
  final dynamic isFromFinnone;
  final dynamic isDataSentToNeo;
  final dynamic typeofOwnershipDd;
  final dynamic siteVisitDate;
  final dynamic isSimilar;
  final dynamic similarPropertyId;

  const DataEntity({
    required this.caseId,
    required this.agencyBranchId,
    required this.bankBranchId,
    required this.propertyId,
    required this.customerId,
    required this.feesId,
    required this.workflowId,
    required this.reportId,
    required this.reportTemplateId,
    required this.agencyBranch,
    required this.applicantName,
    required this.applicantContactNo,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.bankContactPersonName,
    required this.bankContactPersonNumber,
    required this.bankContactPersonEmail,
    required this.loanType,
    required this.bankReferenceNo,
    required this.applicantEmailId,
    required this.applicantAddress,
    required this.reportType,
    required this.reportFile,
    required this.bankName,
    required this.branchName,
    required this.propertyAddress,
    required this.pincode,
    required this.propertyType,
    required this.professionalFees,
    required this.propertyCity,
    required this.propertyLocality,
    required this.villageName,
    required this.district,
    required this.taluka,
    required this.purpose,
    required this.taxType,
    required this.status,
    required this.assignedTo,
    required this.assignedBy,
    required this.assignedAt,
    required this.amountReceived,
    required this.fieldStaff,
    required this.reportMaker,
    required this.reportMakerDate,
    required this.reportChecker,
    required this.reportFinalizer,
    required this.reportDispatcher,
    required this.telecaller,
    required this.caseSourced,
    required this.sourcedBy,
    required this.gharvalueCity,
    required this.gharvalueLocality,
    required this.gharvaluePropertyName,
    required this.customerFeedbackReceived,
    required this.bankFeedbackReceived,
    required this.caseReferenceNumber,
    required this.footerReferenceNumber,
    required this.appointmentDateTime,
    required this.submittedTo,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.signature1,
    required this.signature2,
    required this.acceptanceTime,
    required this.inspectionTime,
    required this.isFromTab,
    required this.shareFolder,
    required this.reportGenerationTime,
    required this.caEmpId,
    required this.typeofOwnership,
    required this.approvedPlanNumber,
    required this.approvedPlanDate,
    required this.approvedPlanApprovingAuthority,
    required this.approvedPlanPreparedBy,
    required this.commencementCertificateNumber,
    required this.commencementCertificateDate,
    required this.commencementApprovingAuthority,
    required this.commencementCertificatePreparedBy,
    required this.approvedRoleId,
    required this.subBranch,
    required this.assignedBranchId,
    required this.approvalNote,
    required this.rejectionNote,
    required this.qcStatus,
    required this.qcNote,
    required this.qcAssignedOn,
    required this.caAgencyBranchId,
    required this.fsAgencyBranchId,
    required this.rmAgencyBranchId,
    required this.rmStatus,
    required this.rmNote,
    required this.rmAssignedOn,
    required this.rmAssignedBy,
    required this.rmqcNote,
    required this.rmqcStatus,
    required this.rmqcAssignedOn,
    required this.approvalId,
    required this.assignedRaBranchId,
    required this.architectEngineerLicenseNo,
    required this.caseAdmin,
    required this.multiCase,
    required this.isCloned,
    required this.isTransferedCase,
    required this.isSignedDocument,
    required this.isSignedDocumentViewed,
    required this.qcCompleteNote,
    required this.qcCompletedDate,
    required this.distanceKm,
    required this.straightLineDistanceKm,
    required this.uniqueIDofthevaluation,
    required this.productSchemeName,
    required this.isFromFinnone,
    required this.isDataSentToNeo,
    required this.typeofOwnershipDd,
    required this.siteVisitDate,
    required this.isSimilar,
    required this.similarPropertyId,
  });

  @override
  List<Object?> get props => [
        caseId,
        agencyBranchId,
        bankBranchId,
        propertyId,
        customerId,
        feesId,
        workflowId,
        reportId,
        reportTemplateId,
        agencyBranch,
        applicantName,
        applicantContactNo,
        contactPersonName,
        contactPersonNumber,
        bankContactPersonName,
        bankContactPersonNumber,
        bankContactPersonEmail,
        loanType,
        bankReferenceNo,
        applicantEmailId,
        applicantAddress,
        reportType,
        reportFile,
        bankName,
        branchName,
        propertyAddress,
        pincode,
        propertyType,
        professionalFees,
        propertyCity,
        propertyLocality,
        villageName,
        district,
        taluka,
        purpose,
        taxType,
        status,
        assignedTo,
        assignedBy,
        assignedAt,
        amountReceived,
        fieldStaff,
        reportMaker,
        reportMakerDate,
        reportChecker,
        reportFinalizer,
        reportDispatcher,
        telecaller,
        caseSourced,
        sourcedBy,
        gharvalueCity,
        gharvalueLocality,
        gharvaluePropertyName,
        customerFeedbackReceived,
        bankFeedbackReceived,
        caseReferenceNumber,
        footerReferenceNumber,
        appointmentDateTime,
        submittedTo,
        createdOn,
        createdBy,
        modifiedOn,
        modifiedBy,
        signature1,
        signature2,
        acceptanceTime,
        inspectionTime,
        isFromTab,
        shareFolder,
        reportGenerationTime,
        caEmpId,
        typeofOwnership,
        approvedPlanNumber,
        approvedPlanDate,
        approvedPlanApprovingAuthority,
        approvedPlanPreparedBy,
        commencementCertificateNumber,
        commencementCertificateDate,
        commencementApprovingAuthority,
        commencementCertificatePreparedBy,
        approvedRoleId,
        subBranch,
        assignedBranchId,
        approvalNote,
        rejectionNote,
        qcStatus,
        qcNote,
        qcAssignedOn,
        caAgencyBranchId,
        fsAgencyBranchId,
        rmAgencyBranchId,
        rmStatus,
        rmNote,
        rmAssignedOn,
        rmAssignedBy,
        rmqcNote,
        rmqcStatus,
        rmqcAssignedOn,
        approvalId,
        assignedRaBranchId,
        architectEngineerLicenseNo,
        caseAdmin,
        multiCase,
        isCloned,
        isTransferedCase,
        isSignedDocument,
        isSignedDocumentViewed,
        qcCompleteNote,
        qcCompletedDate,
        distanceKm,
        straightLineDistanceKm,
        uniqueIDofthevaluation,
        productSchemeName,
        isFromFinnone,
        isDataSentToNeo,
        typeofOwnershipDd,
        siteVisitDate,
        isSimilar,
        similarPropertyId,
      ];
}
