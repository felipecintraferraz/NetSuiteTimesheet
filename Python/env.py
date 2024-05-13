import os
from dotenv import load_dotenv
import random

project_path = os.path.abspath(
    os.path.join(os.path.abspath(os.path.join(os.path.abspath(os.path.join(__file__, os.pardir)), os.pardir))))
dotenv_file = os.path.join(project_path, '.env')
backup_codes_file = os.path.join(project_path, 'backup_codes.txt')

load_dotenv(dotenv_path=dotenv_file)

def get_random_line_from_file(file_path):
    with open(file_path, 'r+') as file:
        lines = file.readlines()
        if lines:
            random_line = random.choice(lines)
            lines.remove(random_line)
            file.seek(0)
            file.truncate()
            file.writelines(lines)
            return random_line.strip()
        else:
            return None


URL = os.getenv('URL')
EMAIL = os.getenv('EMAIL')
PASSWORD = os.getenv('PASSWORD')
DEFAULT_TIMEOUT = '30s'
TWO_FA_CODE = get_random_line_from_file(backup_codes_file)

HEADLESS = True