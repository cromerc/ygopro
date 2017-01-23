--Wall Shadow (Anime)
function c511000477.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,67284908,30778711,true,true)
	--move
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000477,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511000477.seqtg)
	e1:SetOperation(c511000477.seqop)
	c:RegisterEffect(e1)
	--move
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000477,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000477.seqcon)
	e2:SetTarget(c511000477.seqtg)
	e2:SetOperation(c511000477.seqop)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c511000477.dircon)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetValue(c511000477.tgval)
	c:RegisterEffect(e4)
	--change pos
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000477,0))
	e5:SetCategory(CATEGORY_POSITION)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BE_BATTLE_TARGET)
	e5:SetTarget(c511000477.target)
	e5:SetOperation(c511000477.operation)
	c:RegisterEffect(e5)
end
function c511000477.seqcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000477.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
end
function c511000477.seqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
	if s==1 then nseq=0
	elseif s==2 then nseq=1
	elseif s==4 then nseq=2
	elseif s==8 then nseq=3
	else nseq=4 end
	Duel.MoveSequence(c,nseq)
end
function c511000477.dircon(e)
	local p=1-e:GetHandlerPlayer()
	local seq=4-e:GetHandler():GetSequence()
	return Duel.GetFieldCard(p,LOCATION_MZONE,seq)==nil
end
function c511000477.tgval(e,c)
	return e:GetHandler():GetSequence()+c:GetSequence()~=4
end
function c511000477.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c511000477.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
