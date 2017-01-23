--ルーンアイズ・ペンデュラム・ドラゴン
function c511002809.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xf2),aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),true)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511002809.condition)
	e1:SetOperation(c511002809.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c511002809.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c511002809.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION
end
function c511002809.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local flag=e:GetLabel()
	if bit.band(flag,0x7)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		if flag==0x4 then
			e1:SetValue(4)
		elseif flag==0x2 then
			e1:SetDescription(aux.Stringid(1516510,1))
			e1:SetValue(2)
		else
			e1:SetDescription(aux.Stringid(1516510,0))
			e1:SetValue(1)
		end
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c511002809.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	if g:GetCount()==2 then
		local lg2=g:Filter(Card.IsRace,nil,RACE_SPELLCASTER)
		local lv=lg2:GetFirst():GetOriginalLevel()
		if lv==5 or lv==6 then
			flag=0x2
		elseif lv>6 then
			flag=0x4
		elseif lv>0 then
			flag=0x1
		end
	end
	e:GetLabelObject():SetLabel(flag)
end
