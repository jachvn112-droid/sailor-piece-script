"""
Linkvertise Bypass - dung curl_cffi (khong can trinh duyet)
Bypass hoan toan thoi gian cho 30s, lay link dich ngay lap tuc

Cai dat:
    python -m pip install curl_cffi

Su dung:
    python bas.py
    python bas.py https://linkvertise.com/224725/NPAC
"""

import re
import sys
import json
import time
import random

sys.stdout.reconfigure(encoding='utf-8')

from curl_cffi.requests import Session


class LinkvertiseBypass:

    GQL = 'https://publisher.linkvertise.com/graphql'

    Q_CONTENT = """query getContent($identifier: PublicLinkIdentificationInput!, $a: String) {
      getContent(input: $identifier, action_id: $a) {
        ... on ContentAccessTaskSet { __typename tasks { __typename id status
          ... on AdTask { __typename id status ads { completion_token countdown __typename } }
          ... on PremiumTask { __typename id status }
          ... on WaitTask { __typename id remainingWaitingTime status }
        } }
        ... on DetailPageTargetData { type url paste __typename }
        __typename
      }
    }"""

    M_START = """mutation s($input: PublicLinkIdentificationInput!, $task_id: String!) {
      startTask(input: $input, task_id: $task_id) { __typename }
    }"""

    M_COMPLETE = """mutation c($input: PublicLinkIdentificationInput!, $task_id: String!) {
      completeTask(input: $input, task_id: $task_id) { __typename }
    }"""

    BROWSERS = ['chrome120', 'chrome116', 'chrome110', 'chrome107',
                'chrome100', 'edge101', 'safari15_5']

    def __init__(self):
        self.headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Origin': 'https://linkvertise.com',
            'Referer': 'https://linkvertise.com/',
        }
        self.session = None

    def _find_working_session(self):
        """Thu tung browser impersonation cho den khi bypass Cloudflare"""
        print('[*] Bypass Cloudflare...')
        # Quick test: GraphQL ping
        test_gql = {
            'operationName': 'getContent',
            'variables': {'identifier': {'userIdAndUrl': {'url': 'test', 'user_id': '1'}}},
            'query': 'query getContent($identifier: PublicLinkIdentificationInput!) { getContent(input: $identifier) { __typename } }',
        }
        for br in self.BROWSERS:
            try:
                s = Session(impersonate=br)
                r = s.post(self.GQL, json=test_gql, headers=self.headers)
                if r.status_code == 200:
                    print(f'[OK] Browser: {br}')
                    self.session = s
                    return True
                else:
                    print(f'  [-] {br} -> {r.status_code}')
            except Exception as e:
                print(f'  [-] {br} -> {str(e)[:50]}')
        return False

    def _gql(self, op, query, variables):
        r = self.session.post(self.GQL, json={
            'operationName': op, 'variables': variables, 'query': query
        }, headers=self.headers)
        if r.status_code == 200:
            try:
                return r.json()
            except:
                return None
        return None

    def bypass(self, url):
        m = re.search(r'/(\d+)/([^/?#]+)', url)
        if not m:
            print('[!] URL khong hop le')
            return None

        user_id, slug = m.group(1), m.group(2)
        ident = {'userIdAndUrl': {'url': slug, 'user_id': user_id}}
        print(f'[*] Link: {user_id}/{slug}')

        # 1. Bypass Cloudflare
        if not self._find_working_session():
            print('[!] Khong bypass duoc Cloudflare')
            print('[!] Thu bat VPN hoac doi mang')
            return None

        # 2. Loop: getContent -> startTask -> completeTask
        for rd in range(1, 6):
            print(f'\n--- Vong {rd} ---')

            data = self._gql('getContent', self.Q_CONTENT, {'identifier': ident})
            if not data:
                print('[!] GraphQL loi')
                return None

            content = data.get('data', {}).get('getContent', {})
            typename = content.get('__typename')

            # Da co URL dich
            if typename == 'DetailPageTargetData':
                target = content.get('url') or content.get('paste')
                print(f'\n[OK] URL dich: {target}')
                return target

            if typename != 'ContentAccessTaskSet':
                print(f'[!] Response la kieu: {typename}')
                return None

            # Complete tat ca task
            tasks = content.get('tasks', [])
            print(f'[*] {len(tasks)} task')

            for task in tasks:
                tid = task['id']
                ttype = task['__typename']
                status = task.get('status', '')

                if status == 'COMPLETED':
                    print(f'  [{ttype}] -> da xong')
                    continue

                # startTask
                self._gql('s', self.M_START, {'input': ident, 'task_id': tid})

                # WaitTask: can cho remainingWaitingTime
                if ttype == 'WaitTask':
                    wait = task.get('remainingWaitingTime', 0)
                    if wait and wait > 0:
                        print(f'  [WaitTask] cho {wait}s...', end='', flush=True)
                        time.sleep(wait)
                        print(' xong!', end='')
                    else:
                        print(f'  [WaitTask]', end='')
                else:
                    print(f'  [{ttype}]', end='')

                cr = self._gql('c', self.M_COMPLETE, {'input': ident, 'task_id': tid})
                ok = cr and not cr.get('errors')
                print(f' -> {"OK" if ok else "FAIL"}')

        print('[!] Da 5 vong, khong lay duoc URL')
        return None


if __name__ == "__main__":
    url = sys.argv[1] if len(sys.argv) > 1 else "https://linkvertise.com/224725/NPAC"

    print('=' * 55)
    print('  LINKVERTISE BYPASS (no browser, no wait)')
    print('=' * 55)

    b = LinkvertiseBypass()
    result = b.bypass(url)

    print('\n' + '=' * 55)
    if result:
        print(f'  THANH CONG: {result}')
    else:
        print('  THAT BAI - doi IP/VPN')
    print('=' * 55)