import React from 'react';
import Container from '../../components/container/Container';
import ItemContainer from '../../components/container/ItemContainer';
import ItemHeader from '../../components/container/ItemHeader';
import Title from '../../components/text/Title';
import Menu from '../../components/Menu';
import LabelContainer from '../../components/container/LabelContainer';

export default function LabelPage() {
  return (
    <Container>
      <Menu name="label" link="/label"></Menu>
      <ItemContainer>
        <ItemHeader>
          <Title text={'labels'} />
        </ItemHeader>
        <LabelContainer
          name="라벨 이름"
          color="#123456"
          description="라벨 설명"
        ></LabelContainer>
      </ItemContainer>
    </Container>
  );
}
