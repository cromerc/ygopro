--Wonderbeat Elf
--scripted by:urielkama
function c511004108.initial_effect(c)
--must attack
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_MUST_ATTACK)
e1:SetCondition(c511004108.facon)
c:RegisterEffect(e1)
--multiple attacks
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e2:SetCode(EVENT_BATTLE_CONFIRM)
e2:SetOperation(c511004108.atop)
c:RegisterEffect(e2)
end
--OCG elf collection
c511004108.collection={
[44663232]=true;[98582704]=true;[39897277]=true;
[93221206]=true;[97170107]=true;[85239662]=true;
[68625727]=true;[59983499]=true;[21417692]=true;
[69140098]=true;[42386471]=true;[61807040]=true;
[11613567]=true;[15025844]=true;[98299011]=true;
}
function c511004108.facon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c511004108.atfilter(c)
	return c:IsFaceup() and (c511004108.collection[c:GetCode()] or c:IsSetCard(0xe4) or c:IsSetCard(0x405))
end
function c511004108.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c511004108.atfilter,tp,LOCATION_MZONE,0,nil)
	local ct=g:GetCount()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(ct)
	c:RegisterEffect(e1)
end
