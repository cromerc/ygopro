--スカブ・スカーナイト
function c100000224.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c100000224.sdcon)
	c:RegisterEffect(e2)
	--must attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_MUST_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e3)	
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_MUST_BE_ATTACKED)
	e4:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_BATTLED)
	e5:SetCondition(c100000224.condition)
	e5:SetOperation(c100000224.operation)
	c:RegisterEffect(e5)	
	local e6=Effect.CreateEffect(c)		
	e1:SetCategory(CATEGORY_CONTROL)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCountLimit(1)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetTarget(c100000224.target)
	e6:SetOperation(c100000224.activate)
	c:RegisterEffect(e6)		
	--only 1 can exists
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_SUMMON)
	e7:SetCondition(c100000224.excon)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e9:SetCode(EFFECT_SPSUMMON_CONDITION)
	e9:SetValue(c100000224.splimit)
	c:RegisterEffect(e9)
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetCode(EFFECT_SELF_DESTROY)
	ea:SetCondition(c100000224.descon)
	c:RegisterEffect(ea)
end
function c100000224.sdcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENCE)
end
function c100000224.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler() or Duel.GetAttacker()==e:GetHandler()
end
function c100000224.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=e:GetHandler():GetBattleTarget()
	tg:RegisterFlagEffect(100000224,RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END,0,1) 
end
function c100000224.cfilter(c,tp)
	return c:GetFlagEffect(100000224)~=0 and c:GetControler()~=tp and c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c100000224.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(c100000224.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c100000224.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c100000224.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not Duel.GetControl(tc,tp) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
function c100000224.exfilter(c,fid)
	return c:IsFaceup() and c:GetCode()==100000224 and (fid==nil or c:GetFieldID()<fid)
end
function c100000224.excon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c100000224.exfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c100000224.splimit(e,se,sp,st,spos,tgp)
	return not Duel.IsExistingMatchingCard(c100000224.exfilter,tgp,LOCATION_ONFIELD,0,1,nil)
end
function c100000224.descon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c100000224.exfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil,c:GetFieldID())
end
