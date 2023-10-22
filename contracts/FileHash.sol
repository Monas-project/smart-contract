// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FileHashRegistry {
    // ユーザーアドレス -> (連番 -> ファイルのハッシュ) のマッピング
    mapping(address => mapping(uint256 => bytes32)) public userHashes;
    mapping(address => uint256) public userHashCounts;

    event HashRegistered(address indexed user, uint256 indexed count, bytes32 hash);

    // ユーザーアドレスとファイルのハッシュを受け取り、マッピングに保存
    function registerHash(bytes32 fileHash) public {
        uint256 currentCount = userHashCounts[msg.sender];
        userHashes[msg.sender][currentCount] = fileHash;
        userHashCounts[msg.sender]++;
        
        emit HashRegistered(msg.sender, currentCount, fileHash);
    }

    // ユーザーアドレスとファイルのハッシュを受け取り、マッピングに存在するか検証
    function verifyHash(address user, bytes32 fileHash) public view returns(bool) {
        uint256 count = userHashCounts[user];
        for(uint256 i = 0; i < count; i++) {
            if(userHashes[user][i] == fileHash) {
                return true;
            }
        }
        return false;
    }
}
