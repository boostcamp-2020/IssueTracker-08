import React, { useState } from 'react';
import LabelStore from '../../stores/LabelStore';
import Container from '../../components/shared/container/Container';
import ItemContainer from '../../components/shared/container/ItemContainer';
import ItemHeader from '../../components/shared/container/ItemHeader';
import LabelTitle from '../../components/label/LabelTitle';
import Menu from '../../components/shared/container/Menu';
import LabelForm from '../../components/label/LabelForm';
import LabelList from '../../components/label/LabelList';

export default function LabelPage() {
  return (
    <LabelStore>
      <Container>
        <Menu name="label" link="/label"></Menu>
        <LabelForm initName="" initDescription="" />
        <ItemContainer>
          <ItemHeader>
            <LabelTitle />
          </ItemHeader>
          <LabelList />
        </ItemContainer>
      </Container>
    </LabelStore>
  );
}
