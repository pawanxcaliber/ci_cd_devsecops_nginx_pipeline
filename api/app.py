from flask import Flask

app = Flask(__name__)
CORS(app, origins="https://my-devsecops-ui.onrender.com")  # Fixing CORS issue

@app.route('/api/message')
def get_message():
    return 'Hello from the backend!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000) # nosec