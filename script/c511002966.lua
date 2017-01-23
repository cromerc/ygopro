--Amazoness Secret Hot Spring
function c511002966.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--confirm
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetDescription(aux.Stringid(90519313,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511002966.rectg)
	e2:SetOperation(c511002966.recop)
	c:RegisterEffect(e2)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c511002966.descon)
	c:RegisterEffect(e4)
	if not c511002966.global_check then
		c511002966.global_check=true
		c511002966[0]={}
		c511002966[1]={}
		c511002966[2]=0
		c511002966[3]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c511002966.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002966.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002966.checkop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then
		c511002966[tp+2]=c511002966[tp+2]+1
		c511002966[tp][c511002966[tp+2]]=ev
	end
	if ep==1-tp then
		c511002966[1-tp+2]=c511002966[1-tp+2]+1
		c511002966[1-tp][c511002966[1-tp+2]]=ev
	end
end
function c511002966.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002966[0]={}
	c511002966[1]={}
	c511002966[2]=0
	c511002966[3]=0
end
function c511002966.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4)
end
function c511002966.descon(e)
	return not Duel.IsExistingMatchingCard(c511002966.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511002966.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c511002966[2+tp]>0 end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c511002966.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local t=c511002966[tp]
	local lp=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.Recover(tp,lp,REASON_EFFECT)
end
