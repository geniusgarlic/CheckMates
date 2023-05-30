// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClaimContract {
    struct Claim {
        string name;
        string description;
        string proofStatement;
        string proofURL;
        string timeModality;
        uint deadline;
    }

    mapping(address => Claim) public claims;

    event ClaimCreated(
        address indexed claimant,
        string name,
        string description,
        string proofStatement,
        string proofURL,
        string timeModality,
        uint deadline
    );

    function createClaim(
        string memory _name,
        string memory _description,
        string memory _proofStatement,
        string memory _proofURL,
        string memory _timeModality,
        uint _deadline
    ) public {
        require(bytes(_name).length > 0, "Name is required");
        require(bytes(_description).length > 0, "Description is required");
        require(bytes(_proofStatement).length > 0, "Proof statement is required");
        require(bytes(_proofURL).length > 0, "Proof URL is required");
        require(bytes(_timeModality).length > 0, "Time modality is required");
        require(_deadline > block.timestamp, "Deadline must be in the future");

        Claim storage claim = claims[msg.sender];
        require(claim.deadline < block.timestamp || bytes(claim.name).length == 0, "Active claim already exists");

        claims[msg.sender] = Claim(_name, _description, _proofStatement, _proofURL, _timeModality, _deadline);
        emit ClaimCreated(msg.sender, _name, _description, _proofStatement, _proofURL, _timeModality, _deadline);
    }
}
