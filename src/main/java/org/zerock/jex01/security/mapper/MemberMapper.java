package org.zerock.jex01.security.mapper;

import org.zerock.jex01.security.domain.Member;

public interface MemberMapper {

    Member findByMid(String mid); // 임포트 조심. 시큐리티 도메인 멤버를 써야함.
}
