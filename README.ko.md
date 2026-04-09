# ⚡ nililia-bootstrap

[English](./README.md) | **한국어**

커맨드 하나로 프로젝트 하네스 세팅. 가볍게.

```
/nililia-bootstrap
```

질문 6개에 답하면 완성 — 워크플로우 게이트, 품질 가드, 에이전트 4개, hooks, 세션 메모리, 멀티 플랫폼.

---

## 문제

Claude Code는 세션이 길어지면 같은 실수를 반복하고, 파일을 읽지 않고 수정하고, 거절이 반복되면 품질을 낮춥니다. 대부분의 하네스는 에이전트와 스킬을 추가해서 대응하지만, 그 자체가 컨텍스트 윈도우를 잡아먹습니다.

**이 부트스트래퍼는 반대로 갑니다.** 파일 15개. 에이전트 4개. 규칙 파일 3개. 모든 규칙은 실제로 반복 발생한 문제를 해결합니다.

---

## 핵심 기능

### 5단계 워크플로우 게이트
**탐색 → 명세 → 계획 → 실행 → 검토** — 각 단계 전환 시 사용자 확인 필수.

### Read-Before-Write
수정 전 최소 3개 관련 파일 읽기. 전체 파일 덮어쓰기 금지. 같은 파일 3회 연속 수정 시 자동 중단.

### 정직한 출력 가드
반복 거절 후 품질 저하 방지. 자기 출력 품질 저하 감지 시 멈추고 보고. 정확성 > 동의.

### 캐시 보호
세션 중 모델 전환, CLAUDE.md 동적 값, MCP 변경 차단 — 프롬프트 캐시 무효화 = 비용 5배.

### 실패→지식 루프
거절 → LESSONS.md 기록 → 반복 패턴 → rules/ 승격 → 같은 실수 영구 차단.

### 에이전트 4개
| 에이전트 | 역할 | 수정 권한 |
|---------|------|----------|
| reviewer | 다각도 코드 리뷰 | ❌ 읽기 전용 |
| planner | 계획 + Agent Teams | ❌ 읽기 전용 |
| researcher | 라이브러리/API 조사 | ❌ 읽기 전용 |
| test-engineer | 테스트 작성 + 커버리지 | ✅ 테스트 파일만 |

### 멀티 플랫폼
Claude Code · Cursor · VS Code (GitHub Copilot)

---

## 설치

```bash
mkdir -p ~/.claude/commands
cp nililia-bootstrap.md ~/.claude/commands/nililia-bootstrap.md
```

```
claude
> /nililia-bootstrap
```

---

## 라이선스

MIT
