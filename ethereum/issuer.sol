contract Issuer {

  address owner;

  address jsonLdContext;
  address jsonLdType;
  string id;
  string name;
  string url;
  string description;
  string image;
  string email;
  address revocationList;

  mapping (uint => address) public BadgeClasses;

  function Issuer(
    address _jsonLdContext,
    address _jsonLdType,
    string _name,
    string _url
  ) {

    owner = msg.sender;

    jsonLdContext = _jsonLdContext;
    jsonLdType = _jsonLdType;
    name = _name;
    url = _url;

  }

}
