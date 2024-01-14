from fpdf import FPDF
import pandas as pd

pdf = FPDF(orientation="P" , format="A4" , unit="mm")
pdf.set_auto_page_break(margin=0,auto=False)

df = pd.read_csv("topics.csv")
#A4 sheet length =298mm and breadth = 210 mm
for index , row in df.iterrows():
    pdf.add_page()
    #ln=1 to add the further lines in next lines
    pdf.set_font(family="times"  ,style ="B", size=22)
    pdf.cell(w=0 , h=10 , txt=row["Topic"] , align="l",ln=1)
    pdf.line(10,20,200,20)


    #footer
    pdf.ln(260)
    pdf.set_font(family="Times", style="I", size=8)
    pdf.set_text_color(100,100,100)
    pdf.cell(w=0,h=10,txt=row["Topic"], align="r")

    for i in range(row["Pages"]-1):
        pdf.add_page()

        #footer
        pdf.ln(270)
        pdf.set_font(family="Times", style="I", size=8)
        pdf.set_text_color(100, 100, 100)
        pdf.cell(w=0, h=10, txt=row["Topic"], align="r")

pdf.output("output.pdf")