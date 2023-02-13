pragma solidity ^0.5.5;

/**
 * @dev String operations.
 */
library Strings {
  bytes16 private constant alphabet = "0123456789abcdef";

  /**
    * @dev Converts a `uint256` to its ASCII `string` decimal representation.
    */
  function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT licence
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

    if (value == 0) {
      return "0";
    }
    uint256 temp = value;
    uint256 digits;
    while (temp != 0) {
      digits++;
      temp /= 10;
    }
    bytes memory buffer = new bytes(digits);
    while (value != 0) {
      digits -= 1;
      buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
      value /= 10;
    }
    return string(buffer);
}

/**
  * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
  */
function toHexString(uint256 value) internal pure returns (string memory) {
    if (value == 0) {
      return "0x00";
    }
    uint256 temp = value;
    uint256 length = 0;
    while (temp != 0) {
      length++;
      temp >>= 8;
    }
    return toHexString(value, length);
}

/**
  * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
  */
function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
    bytes memory buffer = new bytes(2 * length + 2);
    buffer[0] = "0";
    buffer[1] = "x";
    for (uint256 i = 2 * length + 1; i > 1; --i) {
      buffer[i] = alphabet[value & 0xf];
      value >>= 4;
    }
    require(value == 0, "Strings: hex length insufficient");
    return string(buffer);
  }
}

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
  /**
    * @dev Returns true if this contract implements the interface defined by
    * `interfaceId`. See the corresponding
    * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
    * to learn more about how these ids are created.
    *
    * This function call must use less than 30 000 gas.
    */
  function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 *
 * Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation.
 */
// contract ERC165 is IERC165 {
//   /**
//     * @dev See {IERC165-supportsInterface}.
//     */
//   function supportsInterface(bytes4 interfaceId) public view returns (bool) {
//     return interfaceId == type(IERC165).interfaceId;
//   }
// }

contract ERC165 is IERC165 {
  /**
    * @dev Mapping of interface ids to whether or not it's supported.
    */
  mapping(bytes4 => bool) private _supportedInterfaces;

  /**
    * @dev See {IERC165-supportsInterface}.
    */
  function supportsInterface(bytes4 interfaceId) public view returns (bool) {
    return _supportedInterfaces[interfaceId];
  }

  /**
    * @dev Registers the contract as an implementer of the interface defined by
    * `interfaceId`. Support of the actual ERC165 interface is automatic and
    * registering its interface id is not required.
    *
    * See {IERC165-supportsInterface}.
    *
    * Requirements:
    *
    * - `interfaceId` cannot be the ERC165 invalid interface (`0xffffffff`).
    */
  function _registerInterface(bytes4 interfaceId) internal {
    require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
    _supportedInterfaces[interfaceId] = true;
  }
}

// ========================================================
/**
 * @dev Required interface of an ERC721 compliant contract.
 */
contract IERC721 is ERC165 {
  /**
    * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
    */
  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

  /**
    * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
    */
  event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

  /**
    * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
    */
  event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

  /**
    * @dev Returns the number of tokens in ``owner``'s account.
    */
  function balanceOf(address owner) external view returns (uint256 balance);

  /**
    * @dev Returns the owner of the `tokenId` token.
    *
    * Requirements:
    *
    * - `tokenId` must exist.
    */
  function ownerOf(uint256 tokenId) external view returns (address owner);

  /**
    * @dev Safely transfers `tokenId` token from `from` to `to`.
    *
    * Requirements:
    *
    * - `from` cannot be the zero address.
    * - `to` cannot be the zero address.
    * - `tokenId` token must exist and be owned by `from`.
    * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
    * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
    *
    * Emits a {Transfer} event.
    */
  function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
  /**
    * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
    * are aware of the ERC721 protocol to prevent tokens from being forever locked.
    *
    * Requirements:
    *
    * - `from` cannot be the zero address.
    * - `to` cannot be the zero address.
    * - `tokenId` token must exist and be owned by `from`.
    * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or {setApprovalForAll}.
    * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
    *
    * Emits a {Transfer} event.
    */
  function safeTransferFrom(address from, address to, uint256 tokenId) external;

  /**
    * @dev Transfers `tokenId` token from `from` to `to`.
    *
    * WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
    * or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
    * understand this adds an external call which potentially creates a reentrancy vulnerability.
    *
    * Requirements:
    *
    * - `from` cannot be the zero address.
    * - `to` cannot be the zero address.
    * - `tokenId` token must be owned by `from`.
    * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
    *
    * Emits a {Transfer} event.
    */
  function transferFrom(address from, address to, uint256 tokenId) external;

  /**
    * @dev Gives permission to `to` to transfer `tokenId` token to another account.
    * The approval is cleared when the token is transferred.
    *
    * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
    *
    * Requirements:
    *
    * - The caller must own the token or be an approved operator.
    * - `tokenId` must exist.
    *
    * Emits an {Approval} event.
    */
  function approve(address to, uint256 tokenId) external;

  /**
    * @dev Approve or remove `operator` as an operator for the caller.
    * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
    *
    * Requirements:
    *
    * - The `operator` cannot be the caller.
    *
    * Emits an {ApprovalForAll} event.
    */
  function setApprovalForAll(address operator, bool approved) external;

  /**
    * @dev Returns the account approved for `tokenId` token.
    *
    * Requirements:
    *
    * - `tokenId` must exist.
    */
  function getApproved(uint256 tokenId) external view returns (address operator);

  /**
    * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
    *
    * See {setApprovalForAll}
    */
  function isApprovedForAll(address owner, address operator) external view returns (bool);
}
// ========================================================
/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
  /**
    * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
    * by `operator` from `from`, this function is called.
    *
    * It must return its Solidity selector to confirm the token transfer.
    * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
    *
    * The selector can be obtained in Solidity with `IERC721Receiver.onERC721Received.selector`.
    */
  function onERC721Received(
    address operator,
    address from,
    uint256 tokenId,
    bytes calldata
  ) external returns (bytes4);
}
// ========================================================
contract IERC721Metadata is IERC721 {
  /**
    * @dev Returns the token collection name.
    */
  function name() external view returns (string memory);

  /**
    * @dev Returns the token collection symbol.
    */
  function symbol() external view returns (string memory);

  /**
    * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
    */
  function tokenURI(uint256 tokenId) external view returns (string memory);
}


// ========================================================
// ========================================================
// ========================================================
// ========================================================
/// @title ERC-721 Non-Fungible Token Standard
/// @dev See https://eips.ethereum.org/EIPS/eip-721
///  Note: the ERC-165 identifier for this interface is 0x80ac58cd.
contract ERC721 is ERC165, IERC721, IERC721Metadata {
  // Token name
  string private _name = 'ERC721Token';

  // Token symbol
  string private _symbol = 'ER7T';

  // Mapping from token ID to owner address
  mapping(uint256 => address) private _owners;

  // Mapping owner address to token count
  mapping(address => uint256) private _balances;

  // Mapping from token ID to approved address
  mapping(uint256 => address) private _tokenApprovals;

  // Mapping from owner to operator approvals
  mapping(address => mapping(address => bool)) private _operatorApprovals;

  mapping(bytes4 => bool) private _supportedInterfaces;

  /**
    * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
    */
  constructor() public {
    // _name = name_;
    // _symbol = symbol_;
  }

  /**
    * @dev See {IERC165-supportsInterface}.
    */
  function supportsInterface(bytes4 interfaceId) public view returns (bool) {
    return _supportedInterfaces[interfaceId] ||
        super.supportsInterface(interfaceId);
  }

  /**
    * @dev See {IERC721-balanceOf}.
    */
  function balanceOf(address owner) public view returns (uint256) {
    require(owner != address(0), "ERC721: address zero is not a valid owner");
    return _balances[owner];
  }

  /**
    * @dev See {IERC721-ownerOf}.
    */
  function ownerOf(uint256 tokenId) public view returns (address) {
    address owner = _ownerOf(tokenId);
    require(owner != address(0), "ERC721: invalid token ID");
    return owner;
  }

  /**
    * @dev See {IERC721Metadata-name}.
    */
  function name() public view returns (string memory) {
    return _name;
  }

  /**
    * @dev See {IERC721Metadata-symbol}.
    */
  function symbol() public view returns (string memory) {
    return _symbol;
  }

  /**
    * @dev See {IERC721Metadata-tokenURI}.
    */
  function tokenURI(uint256 tokenId) public view returns (string memory) {
    _requireMinted(tokenId);

    string memory baseURI = _baseURI();
    return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, Strings.toString(tokenId))) : "";
  }

  /**
    * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
    * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
    * by default, can be overridden in child contracts.
    */
  function _baseURI() internal view returns (string memory) {
    return "";
  }

  /**
    * @dev See {IERC721-approve}.
    */
  function approve(address to, uint256 tokenId) public {
    address owner = ERC721.ownerOf(tokenId);
    require(to != owner, "ERC721: approval to current owner");

    require(
        msg.sender == owner || isApprovedForAll(owner, msg.sender),
        "ERC721: approve caller is not token owner or approved for all"
    );

    _approve(to, tokenId);
  }

  /**
    * @dev See {IERC721-getApproved}.
    */
  function getApproved(uint256 tokenId) public view returns (address) {
    _requireMinted(tokenId);

    return _tokenApprovals[tokenId];
  }

  /**
    * @dev See {IERC721-setApprovalForAll}.
    */
  function setApprovalForAll(address operator, bool approved) public {
    _setApprovalForAll(msg.sender, operator, approved);
  }

  /**
    * @dev See {IERC721-isApprovedForAll}.
    */
  function isApprovedForAll(address owner, address operator) public view returns (bool) {
    return _operatorApprovals[owner][operator];
  }

  /**
    * @dev See {IERC721-transferFrom}.
    */
  function transferFrom(address from, address to, uint256 tokenId) public {
    //solhint-disable-next-line max-line-length
    require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: caller is not token owner or approved");

    _transfer(from, to, tokenId);
  }

  /**
    * @dev See {IERC721-safeTransferFrom}.
    */
  function safeTransferFrom(address from, address to, uint256 tokenId) public {
    safeTransferFrom(from, to, tokenId, "");
  }

  /**
    * @dev See {IERC721-safeTransferFrom}.
    */
  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public {
    require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: caller is not token owner or approved");
    _safeTransfer(from, to, tokenId, data);
  }

  /**
    * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
    * are aware of the ERC721 protocol to prevent tokens from being forever locked.
    *
    * `data` is additional data, it has no specified format and it is sent in call to `to`.
    *
    * This internal function is equivalent to {safeTransferFrom}, and can be used to e.g.
    * implement alternative mechanisms to perform token transfer, such as signature-based.
    *
    * Requirements:
    *
    * - `from` cannot be the zero address.
    * - `to` cannot be the zero address.
    * - `tokenId` token must exist and be owned by `from`.
    * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
    *
    * Emits a {Transfer} event.
    */
  function _safeTransfer(address from, address to, uint256 tokenId, bytes memory data) internal {
    _transfer(from, to, tokenId);
    require(_checkOnERC721Received(from, to, tokenId, data), "ERC721: transfer to non ERC721Receiver implementer");
  }

  /**
    * @dev Returns the owner of the `tokenId`. Does NOT revert if token doesn't exist
    */
  function _ownerOf(uint256 tokenId) internal view returns (address) {
    return _owners[tokenId];
  }

  /**
    * @dev Returns whether `tokenId` exists.
    *
    * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
    *
    * Tokens start existing when they are minted (`_mint`),
    * and stop existing when they are burned (`_burn`).
    */
  function _exists(uint256 tokenId) internal view returns (bool) {
    return _ownerOf(tokenId) != address(0);
  }

  /**
    * @dev Returns whether `spender` is allowed to manage `tokenId`.
    *
    * Requirements:
    *
    * - `tokenId` must exist.
    */
  function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
    address owner = ERC721.ownerOf(tokenId);
    return (spender == owner || isApprovedForAll(owner, spender) || getApproved(tokenId) == spender);
  }

  /**
    * @dev Safely mints `tokenId` and transfers it to `to`.
    *
    * Requirements:
    *
    * - `tokenId` must not exist.
    * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
    *
    * Emits a {Transfer} event.
    */
  function _safeMint(address to, uint256 tokenId) internal {
    _safeMint(to, tokenId, "");
  }

  /**
    * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is
    * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.
    */
  function _safeMint(address to, uint256 tokenId, bytes memory data) internal {
    _mint(to, tokenId);
    require(
        _checkOnERC721Received(address(0), to, tokenId, data),
        "ERC721: transfer to non ERC721Receiver implementer"
    );
  }

  /**
    * @dev Mints `tokenId` and transfers it to `to`.
    *
    * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible
    *
    * Requirements:
    *
    * - `tokenId` must not exist.
    * - `to` cannot be the zero address.
    *
    * Emits a {Transfer} event.
    */
  function _mint(address to, uint256 tokenId) internal {
    require(to != address(0), "ERC721: mint to the zero address");
    require(!_exists(tokenId), "ERC721: token already minted");

    _beforeTokenTransfer(address(0), to, tokenId, 1);

    // Check that tokenId was not minted by `_beforeTokenTransfer` hook
    require(!_exists(tokenId), "ERC721: token already minted");

    // unchecked {
    //   // Will not overflow unless all 2**256 token ids are minted to the same owner.
    //   // Given that tokens are minted one by one, it is impossible in practice that
    //   // this ever happens. Might change if we allow batch minting.
    //   // The ERC fails to describe this case.
    //   _balances[to] += 1;
    // }

    _owners[tokenId] = to;

    emit Transfer(address(0), to, tokenId);

    _afterTokenTransfer(address(0), to, tokenId, 1);
  }

  /**
    * @dev Destroys `tokenId`.
    * The approval is cleared when the token is burned.
    * This is an internal function that does not check if the sender is authorized to operate on the token.
    *
    * Requirements:
    *
    * - `tokenId` must exist.
    *
    * Emits a {Transfer} event.
    */
  function _burn(uint256 tokenId) internal {
    address owner = ERC721.ownerOf(tokenId);

    _beforeTokenTransfer(owner, address(0), tokenId, 1);

    // Update ownership in case tokenId was transferred by `_beforeTokenTransfer` hook
    owner = ERC721.ownerOf(tokenId);

    // Clear approvals
    delete _tokenApprovals[tokenId];

    // unchecked {
    //   // Cannot overflow, as that would require more tokens to be burned/transferred
    //   // out than the owner initially received through minting and transferring in.
    //   _balances[owner] -= 1;
    // }
    delete _owners[tokenId];

    emit Transfer(owner, address(0), tokenId);

    _afterTokenTransfer(owner, address(0), tokenId, 1);
  }

  /**
    * @dev Transfers `tokenId` from `from` to `to`.
    *  As opposed to {transferFrom}, this imposes no restrictions on msg.sender.
    *
    * Requirements:
    *
    * - `to` cannot be the zero address.
    * - `tokenId` token must be owned by `from`.
    *
    * Emits a {Transfer} event.
    */
  function _transfer(address from, address to, uint256 tokenId) internal {
    require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");
    require(to != address(0), "ERC721: transfer to the zero address");

    _beforeTokenTransfer(from, to, tokenId, 1);

    // Check that tokenId was not transferred by `_beforeTokenTransfer` hook
    require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");

    // Clear approvals from the previous owner
    delete _tokenApprovals[tokenId];

    // unchecked {
    //   // `_balances[from]` cannot overflow for the same reason as described in `_burn`:
    //   // `from`'s balance is the number of token held, which is at least one before the current
    //   // transfer.
    //   // `_balances[to]` could overflow in the conditions described in `_mint`. That would require
    //   // all 2**256 token ids to be minted, which in practice is impossible.
    //   _balances[from] -= 1;
    //   _balances[to] += 1;
    // }
    _owners[tokenId] = to;

    emit Transfer(from, to, tokenId);

    _afterTokenTransfer(from, to, tokenId, 1);
  }

  /**
    * @dev Approve `to` to operate on `tokenId`
    *
    * Emits an {Approval} event.
    */
  function _approve(address to, uint256 tokenId) internal {
    _tokenApprovals[tokenId] = to;
    emit Approval(ERC721.ownerOf(tokenId), to, tokenId);
  }

  /**
    * @dev Approve `operator` to operate on all of `owner` tokens
    *
    * Emits an {ApprovalForAll} event.
    */
  function _setApprovalForAll(address owner, address operator, bool approved) internal {
    require(owner != operator, "ERC721: approve to caller");
    _operatorApprovals[owner][operator] = approved;
    emit ApprovalForAll(owner, operator, approved);
  }

  /**
    * @dev Reverts if the `tokenId` has not been minted yet.
    */
  function _requireMinted(uint256 tokenId) internal view {
    require(_exists(tokenId), "ERC721: invalid token ID");
  }

  /**
    * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
    * The call is not executed if the target address is not a contract.
    *
    * @param from address representing the previous owner of the given token ID
    * @param to target address that will receive the tokens
    * @param tokenId uint256 ID of the token to be transferred
    * @param data bytes optional data to send along with the call
    * @return bool whether the call correctly returned the expected magic value
    */
  function _checkOnERC721Received(
    address from,
    address to,
    uint256 tokenId,
    bytes memory data
  ) private returns (bool) {
    // if (to.isContract()) {
      // try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) returns (bytes4 retval) {
      //     return retval == IERC721Receiver.onERC721Received.selector;
      // } catch (bytes memory reason) {
      //     if (reason.length == 0) {
      //         revert("ERC721: transfer to non ERC721Receiver implementer");
      //     } else {
      //         /// @solidity memory-safe-assembly
      //         assembly {
      //             revert(add(32, reason), mload(reason))
      //         }
      //     }
      // }
    // } else {
    //     return true;
    // }
  }

  /**
    * @dev Hook that is called before any token transfer. This includes minting and burning. If {ERC721Consecutive} is
    * used, the hook may be called as part of a consecutive (batch) mint, as indicated by `batchSize` greater than 1.
    *
    * Calling conditions:
    *
    * - When `from` and `to` are both non-zero, ``from``'s tokens will be transferred to `to`.
    * - When `from` is zero, the tokens will be minted for `to`.
    * - When `to` is zero, ``from``'s tokens will be burned.
    * - `from` and `to` are never both zero.
    * - `batchSize` is non-zero.
    *
    * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
    */
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 /* firstTokenId */,
    uint256 batchSize
  ) internal {
    if (batchSize > 1) {
      if (from != address(0)) {
        _balances[from] -= batchSize;
      }
      if (to != address(0)) {
        _balances[to] += batchSize;
      }
    }
  }

  /**
    * @dev Hook that is called after any token transfer. This includes minting and burning. If {ERC721Consecutive} is
    * used, the hook may be called as part of a consecutive (batch) mint, as indicated by `batchSize` greater than 1.
    *
    * Calling conditions:
    *
    * - When `from` and `to` are both non-zero, ``from``'s tokens were transferred to `to`.
    * - When `from` is zero, the tokens were minted for `to`.
    * - When `to` is zero, ``from``'s tokens were burned.
    * - `from` and `to` are never both zero.
    * - `batchSize` is non-zero.
    *
    * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
    */
  function _afterTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize) internal {}
}
