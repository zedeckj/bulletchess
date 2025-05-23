with open("../scripts/test.html") as f:
    html = f.read()



with open("../scripts/temp.html", "w") as f:
    html = html.replace("%s","<div class = \"bP\"></div>")
    
    f.write(f"""
        <html>
            {html}
        </html>     
    """)