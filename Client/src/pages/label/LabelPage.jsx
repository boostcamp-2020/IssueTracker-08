import React from 'react';
import Container from '../../components/shared/container/Container';
import ItemContainer from '../../components/shared/container/ItemContainer';
import ItemHeader from '../../components/shared/container/ItemHeader';
import Title from '../../components/shared/text/Title';
import Menu from '../../components/shared/container/Menu';
import LabelContainer from '../../components/label/LabelContainer';

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
