from fpdf import FPDF
import pandas as pd
import glob
from pathlib import Path

filepaths = glob.glob("invoices/*.xlsx")

for filepath in filepaths:

    pdf= FPDF(orientation="P"  , format="A4" , unit="mm")

    pdf.add_page()
    #get file name
    filename = Path(filepath).stem
    invoice_nr ,date  =filename.split("-")

    pdf.set_font(family="Times",size=15)
    pdf.cell(w=50 , h=8, txt=f"Invoice nr.{invoice_nr}",ln=1)

    pdf.set_font(family="Times",size=15)
    pdf.cell(w=50 , h=8, txt=f"Date {date}",ln=1)

    df = pd.read_excel(filepath, sheet_name="Sheet 1")

    #add header
    pdf.ln(10)
    columns = df.columns

    columns = [items.replace("_"," ").title() for items in columns]
    pdf.set_font(family="Times", size=13, style="B")
    pdf.cell(w=30, h=10, txt=columns[0], border=1)
    pdf.cell(w=60, h=10, txt=columns[1], border=1)
    pdf.cell(w=40, h=10, txt=columns[2], border=1)
    pdf.cell(w=30, h=10, txt=columns[3], border=1)
    pdf.cell(w=30, h=10, txt=columns[4], border=1 , ln=1)

    #add cells
    for index , row in df.iterrows():
        pdf.set_font(family="Times", size=11)
        pdf.cell(w=30, h=10, txt=str(row["product_id"]),border=1)
        pdf.cell(w=60, h=10, txt=str(row["product_name"]), border=1)
        pdf.cell(w=40, h=10, txt=str(row["amount_purchased"]), border=1)
        pdf.cell(w=30, h=10, txt=str(row["price_per_unit"]), border=1)
        pdf.cell(w=30, h=10, txt=str(row["total_price"]), border=1,ln=1) #ln added to next cell

    total = df["total_price"].sum()
    pdf.set_font(family="Times", size=11)
    pdf.cell(w=30, h=10, txt="", border=1)
    pdf.cell(w=60, h=10, txt="", border=1)
    pdf.cell(w=40, h=10, txt="", border=1)
    pdf.cell(w=30, h=10, txt="", border=1)
    pdf.cell(w=30, h=10, txt=str(total), border=1, ln=1)  # ln added to next cell


    pdf.ln(25)
    pdf.set_font(family="Times", size=13)
    pdf.cell(w=30, h=10, txt=f"Total amount purchased is {total}",ln=1)

    pdf.set_font(family="Times", size=13)
    pdf.cell(w=30, h=10, txt=f"**************************** Thanks for Shopping ****************************")
    #pdf.image("path",w=,h=)
    pdf.output(f"pdfs/{invoice_nr}.pdf")


