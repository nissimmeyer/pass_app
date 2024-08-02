from flask import Flask, request, jsonify

app = Flask(__name__)

# Sample list of passwords
passwords = [
    {"id": 1, "username": "example.com", "password": "password123"},
    {"id": 2, "username": "github.com", "password": "securepass456"},
    {"id": 3, "username": "email.com", "password": "emailpass789"}
]

# Route to get all passwords
@app.route('/passwords/', methods=['GET'])
def get_passwords():
    return jsonify(passwords)
    
# Route to get a password by ID
@app.route('/passwords/<int:password_id>/', methods=['GET'])
def get_password(password_id):
    password = next((password for password in passwords if password["id"] == password_id), None)
    if password:
        return jsonify(password)
    else:
        return jsonify({"error": "Password not found"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5005, debug=True)