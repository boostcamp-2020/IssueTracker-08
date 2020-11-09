import React from 'react';
import Container from '../../components/container/Container';
import ItemContainer from '../../components/container/ItemContainer';
import ItemHeader from '../../components/container/ItemHeader';
import Menu from '../../components/Menu';

export default function MilestonePage() {
  return (
    <Container>
      <Menu link="/milestone/post" name="milestone"></Menu>
      <ItemContainer>
        <ItemHeader></ItemHeader>
      </ItemContainer>
    </Container>
  );
}
