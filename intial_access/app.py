# app.py
from flask import Flask, request, render_template_string

app = Flask(__name__)

# Minimal HTML template with an injection point
PAGE = """
<!doctype html>
<title>Vuln Dashboard</title>
<h1>Enter an expression to evaluate</h1>
<form method=post>
  <input name=expr style="width:300px">
  <input type=submit value="Run">
</form>
{% if result is not none %}
  <h2>Result: {{ result }}</h2>
{% endif %}
"""

@app.route("/", methods=("GET", "POST"))
def index():
    result = None
    if request.method == "POST":
        expr = request.form["expr"]
        # UNSAFE: directly eval user input!
        try:
            result = eval(expr)
        except Exception as e:
            result = f"Error: {e}"
    return render_template_string(PAGE, result=result)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
