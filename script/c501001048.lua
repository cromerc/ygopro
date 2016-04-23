---エルシャドール・ミドラーシュ
function c501001048.initial_effect(c)
	--
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(c501001048.fumfilter1)
							,aux.FilterBoolFunction(c501001048.fumfilter2)
							,true)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c501001048.splimit)
	c:RegisterEffect(e1)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c501001048.indval)
	c:RegisterEffect(e3)
	--disable summon
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(1,1)
	e4:SetTarget(c501001048.tg)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(501001048)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,1)
	c:RegisterEffect(e5)
	--
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(501001048,0))
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetCategory(CATEGORY_TOHAND)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetTarget(c501001048.thtg)
	e6:SetOperation(c501001048.thop)
	c:RegisterEffect(e6)
	if not c501001048.global_check then
		c501001048.global_check=true
		c501001048[0]=0
		c501001048[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c501001048.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c501001048.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c501001048.fumfilter1(c)
	return c:IsCanBeFusionMaterial()
	and c:IsSetCard(0x9b)
end
function c501001048.fumfilter2(c)
	return c:IsCanBeFusionMaterial()
	and (c:IsAttribute(ATTRIBUTE_DARK)
		or (c:IsCode(501001073) and c:GetFlagEffect(c:GetCode())==1)
		)
end
function c501001048.splimit(e,se,sp,st)
	local c=e:GetHandler()
	return not c:IsLocation(LOCATION_EXTRA)
	or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c501001048.indval(e,re,tp)
	return e:GetHandler():GetControler()~=tp
end
function c501001048.tg(e,sc,sp,st)
	return c501001048[sp]>=1
end
function c501001048.checkop(e,tp,eg,ep,ev,re,r,rp)
	local s1=false
	local s2=false
	local tc=eg:GetFirst()
	while tc do
		if tc:GetSummonPlayer()==0 then s1=true
		else s2=true end
		tc=eg:GetNext()
	end
	if s1 then c501001048[0]=c501001048[0]+1 end
	if s2 then c501001048[1]=c501001048[1]+1 end
end
function c501001048.clear(e,tp,eg,ep,ev,re,r,rp)
	c501001048[0]=0
	c501001048[1]=0
end
function c501001048.thfilter(c)
	return c:IsAbleToHand()
	and c:IsSetCard(0x9b)
	and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP))
end
function c501001048.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(c501001048.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c501001048.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,tp,LOCATION_GRAVE)
end	
function c501001048.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end	
