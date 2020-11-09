import React from 'react';
import Container from '../../components/container/Container';
import ItemContainer from '../../components/container/ItemContainer';
import ItemHeader from '../../components/container/ItemHeader';
import Title from '../../components/text/Title';
import Menu from '../../components/Menu';

export default function LabelPage() {
  return (
    <Container>
      <Menu name="label" link="/label"></Menu>
      <ItemContainer>
        <ItemHeader>
          <Title text="labels" />
        </ItemHeader>
      </ItemContainer>
    </Container>
  );
}
