import os
import random
import subprocess

project_path = os.path.abspath(os.path.join(
    os.path.dirname(__file__), os.pardir))

dotenv_file = os.path.join(project_path, '.env')
backup_codes_file = os.path.join(project_path, 'backup_codes.txt')

try:
    from dotenv import load_dotenv
except ModuleNotFoundError:
    load_dotenv = None

if load_dotenv is not None:
    load_dotenv(dotenv_path=dotenv_file)


def get_random_line_from_file(file_path):
    if not os.path.exists(file_path):
        return None
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


def get_oath_using_ykman():
    account = os.getenv('YKMAN_ACCOUNT')
    try:
        result = subprocess.run(
            ["ykman", "oath", "accounts", "code", "-s", account],
            capture_output=True,
            text=True,
            check=True,
        )
    except FileNotFoundError as e:
        raise RuntimeError(
            "ykman was not found on PATH. Install YubiKey Manager CLI or define TWO_FA_CODE.") from e
    code = result.stdout.strip()
    if not code.isdigit():
        raise ValueError("OATH code must be a number")
    return code


HEADLESS = os.getenv('HEADLESS')
URL = os.getenv('URL')
EMAIL = os.getenv('EMAIL')
PASSWORD = os.getenv('PASSWORD')
DEFAULT_TIMEOUT = '30s'
YKMAN_ACCOUNT = os.getenv('YKMAN_ACCOUNT')
USE_YKMAN = bool(YKMAN_ACCOUNT)
TWO_FA_CODE = get_oath_using_ykman(
) if USE_YKMAN else get_random_line_from_file(backup_codes_file)


def _mask_secret(value: object) -> object:
    if value is None:
        return None
    text = str(value)
    if len(text) <= 4:
        return "*" * len(text)
    return f"{text[:2]}{'*' * (len(text) - 4)}{text[-2:]}"


variables = {
    "HEADLESS": HEADLESS,
    "URL": URL,
    "EMAIL": EMAIL,
    "PASSWORD": _mask_secret(PASSWORD),
    "DEFAULT_TIMEOUT": DEFAULT_TIMEOUT,
    "YKMAN_ACCOUNT": YKMAN_ACCOUNT,
    "USE_YKMAN": USE_YKMAN,
    "TWO_FA_CODE": _mask_secret(TWO_FA_CODE),
}
for key, value in variables.items():
    print(f"{key}={value!r}")
