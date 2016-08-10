import json
import requests

class EthRPC:

    eth_url = "http://localhost:8545"
    session = requests.Session()
    request_id = 100

    def _make_request(self, method, params=[]):

        request_body = {
            "jsonrpc": "2.0",
            "method": method,
            "params": params,
            "id": self.request_id
        }

        request_body_json = json.dumps(request_body)
        response = self.session.post(self.eth_url, data=request_body_json)

        # response_body = response.json()
        # response_body["result"] = response_body["result"][2:].decode("hex")
        # response_body["result"]

        print json.dumps(response.json(), indent=2, separators=(",", " : "))

    def web3_clientVersion(self):

        self._make_request("web3_clientVersion")

    def web3_sha3(self, input_string):

        self._make_request("web3_sha3", [input_string])

    def net_version(self):

        self._make_request("net_version")

    def net_listening(self):

        self._make_request("net_listening")

    def net_peerCount(self):

        self._make_request("net_peerCount")

    def eth_protocolVersion(self):

        self._make_request("eth_protocolVersion")

    def eth_syncing(self):

        self._make_request("eth_syncing")

    def eth_coinbase(self):

        self._make_request("eth_coinbase")

    def eth_mining(self):

        self._make_request("eth_mining")

    def eth_hashrate(self):

        self._make_request("eth_hashrate")

    def eth_gasPrice(self):

        self._make_request("eth_gasPrice")

    def eth_accounts(self):

        self._make_request("eth_accounts")

    def eth_blockNumber(self):

        self._make_request("eth_blockNumber")

    def eth_getBalance(self, address, block="latest"):

        self._make_request("eth_getBalance", [address, block])

    def eth_getStorageAt(self, address, storage_position, block="latest"):

        params = [address, storage_position, block]
        self._make_request("eth_getStorageAt", params)

    def eth_getTransactionCount(self, address, block="latest"):

        self._make_request("eth_getTransactionCount", [address, block])
