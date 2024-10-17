
import smtplib
from email.mime.text import MIMEText

# Define SMTP server and authentication details
smtp_server = 'SMTP_SERV'
smtp_port = 25
smtp_username = 'nonexistentuser'
smtp_password = 'nosecret'

# Create an email message
message = MIMEText('This is a test email')
message['Subject'] = 'Test Email'
message['From'] = 'sender@example.com'
message['To'] = 'recipient@example.com'

# Establish a connection to the SMTP server
smtp_connection = smtplib.SMTP(smtp_server, smtp_port)
smtp_connection.starttls()

# Log in to the SMTP server
smtp_connection.login(smtp_username, smtp_password)

# Send the email
smtp_connection.send_message(message)

# Close the SMTP connection
smtp_connection.quit()
