build: resume.pdf
	nikola build

resume.pdf:
	rst2pdf --stylesheet-path=files -s resume,serif,sphinx --smart-quotes=1 -o files/resume.pdf pages/resume.txt
